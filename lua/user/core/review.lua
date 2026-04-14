local nnoremap = require("user.utils.keymap").nnoremap

---@alias DiffStatus "M"|"A"|"D"|"R"

---@class DiffEntry
---@field file string Current name of the file
---@field base_file string|nil Name in the base branch (nil for added files)
---@field status DiffStatus
---@field pure_rename boolean|nil Only present when status == "R"

---@class ReviewState
---@field entries DiffEntry[]
---@field current integer
---@field base string|nil
---@field branch string|nil
---@field active boolean
---@field right_bufs table<string, integer>
---@field left_win integer|nil
---@field right_win integer|nil

-- Git helpers

---@return string|nil
local function detect_base()
	for _, name in ipairs({ "main", "master" }) do
		vim.fn.system("git rev-parse --verify --quiet " .. name)
		if vim.v.shell_error == 0 then
			return name
		end
	end
	return nil
end

---@return string
local function current_branch()
	local branch = vim.fn.system("git branch --show-current"):gsub("%s+$", "")
	if vim.v.shell_error == 0 and branch ~= "" then
		return branch
	end
	return "working copy"
end

---@param base string
---@return DiffEntry[]
local function get_diff_entries(base)
	local lines = vim.fn.systemlist("git diff --name-status -M " .. vim.fn.shellescape(base) .. " -- .")
	---@type DiffEntry[]
	local entries = {}
	local parsers = {
		["R"] = "^[RC](%d*)\t(.+)\t(.+)$",
		["C"] = "^[RC](%d*)\t(.+)\t(.+)$",
		["A"] = "^A\t(.+)$",
		["D"] = "^D\t(.+)$",
		["M"] = "^[MT]\t(.+)$",
		["T"] = "^[MT]\t(.+)$",
	}
	for _, line in ipairs(lines) do
		if line == "" then
			goto continue
		end
		local status = line:sub(1, 1)
		local pattern = parsers[status]
		if not pattern then
			goto continue
		end
		if status == "R" or status == "C" then
			local pct, old_name, new_name = line:match(pattern)
			if old_name then
				table.insert(entries, {
					file = new_name,
					base_file = old_name,
					status = "R",
					pure_rename = pct == "100",
				})
			end
		else
			local name = line:match(pattern)
			if name then
				table.insert(entries, {
					file = name,
					base_file = status ~= "A" and name or nil,
					status = status == "T" and "M" or status,
				})
			end
		end
		::continue::
	end
	return entries
end

---@param base string
---@param path string
---@return string[]|nil
local function fetch_base_content(base, path)
	local content = vim.fn.systemlist("git show " .. vim.fn.shellescape(base .. ":" .. path))
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return content
end

-- Display helpers

---@param path string
---@param max_len integer
---@return string
local function shorten_path(path, max_len)
	if #path <= max_len then
		return path
	end
	local parts = vim.split(path, "/", { plain = true })
	local last = parts[#parts]
	if #parts > 2 then
		local candidate = parts[1] .. "/.../" .. last
		if #candidate <= max_len then
			return candidate
		end
	end
	local candidate = ".../" .. last
	if #candidate <= max_len then
		return candidate
	end
	return last
end

---@param entry DiffEntry
---@return string
local function status_tag(entry)
	local code = entry.status
	if entry.status == "R" and not entry.pure_rename then
		code = "RM"
	end
	return " [" .. code .. "]"
end

---@param pad integer
---@param tag string
---@param path string
---@param hunk_str string
---@param branch string
---@param width integer
---@return string
local function format_winbar(pad, tag, path, hunk_str, branch, width)
	local left_text = tag .. " " .. path
	local right_text = hunk_str .. " | " .. branch
	local avail = width - pad
	local left = "%#DiagnosticInfo#" .. tag .. " %#WinBar#" .. path
	local right = "%#DiagnosticWarn#" .. hunk_str .. "%#WinBarNC# | %#String#" .. branch
	local total = #left_text + #right_text

	local padding = string.rep(" ", pad)
	if total < avail then
		return padding .. left .. string.rep(" ", avail - total) .. right
	elseif total + 1 <= avail then
		return padding .. left .. " " .. right
	elseif #left_text < avail then
		return padding .. left .. string.rep(" ", avail - #left_text)
	end
	return padding .. left
end

---@return integer
local function count_hunks()
	local save_pos = vim.fn.getpos(".")
	vim.cmd("silent! normal! gg")
	local hunks = 0
	while true do
		local prev = vim.fn.line(".")
		vim.cmd("silent! normal! ]c")
		if vim.fn.line(".") == prev and hunks > 0 then
			break
		end
		hunks = hunks + 1
	end
	vim.fn.setpos(".", save_pos)
	return hunks
end

-- Buffer helpers

---@param base string
---@param entry DiffEntry
---@param content string[]|nil
---@return integer buffer handle
local function create_right_buf(base, entry, content)
	local buf = vim.api.nvim_create_buf(false, true)
	if content and entry.status ~= "A" then
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	end
	pcall(vim.api.nvim_buf_set_name, buf, "[" .. base .. "] " .. (entry.base_file or entry.file))
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false
	local ft = vim.filetype.match({ filename = entry.file })
	if ft then
		vim.bo[buf].filetype = ft
	end
	return buf
end

---@param entry DiffEntry
local function open_left_buf(entry)
	if entry.status == "D" then
		vim.cmd("enew")
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { "(deleted)" })
		vim.bo.buftype = "nofile"
		vim.bo.modifiable = false
	else
		vim.cmd("edit " .. vim.fn.fnameescape(entry.file))
	end
end

---@param entry DiffEntry
---@param base string
---@param right_bufs table<string, integer>
---@return integer buffer handle
local function ensure_right_buf(entry, base, right_bufs)
	local buf = right_bufs[entry.file]
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end
	local content = entry.base_file and fetch_base_content(base, entry.base_file) or nil
	buf = create_right_buf(base, entry, content)
	right_bufs[entry.file] = buf
	return buf
end

-- State

---@type ReviewState
local state = {
	entries = {},
	current = 0,
	base = nil,
	branch = nil,
	active = false,
	right_bufs = {},
	left_win = nil,
	right_win = nil,
}

---@param base string
---@param entries DiffEntry[]
local function prefetch(base, entries)
	for _, entry in ipairs(entries) do
		if not entry.base_file then
			vim.schedule(function()
				if state.active then
					state.right_bufs[entry.file] = create_right_buf(base, entry, nil)
				end
			end)
		else
			vim.system({ "git", "show", base .. ":" .. entry.base_file }, { text = true }, function(result)
				vim.schedule(function()
					if not state.active then
						return
					end
					local content
					if result.code == 0 then
						content = vim.split(result.stdout, "\n", { plain = true })
						if content[#content] == "" then
							table.remove(content)
						end
					end
					state.right_bufs[entry.file] = create_right_buf(base, entry, content)
				end)
			end)
		end
	end
end

local function cleanup_bufs()
	for _, buf in pairs(state.right_bufs) do
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

---@return boolean
local function wins_valid()
	return state.left_win ~= nil
		and vim.api.nvim_win_is_valid(state.left_win)
		and state.right_win ~= nil
		and vim.api.nvim_win_is_valid(state.right_win)
end

local function close_split()
	vim.cmd("silent! diffoff!")
	if #vim.api.nvim_tabpage_list_wins(0) > 1 then
		vim.cmd("silent! only")
	end
end

-- Core

local function stop_review()
	if vim.bo.modified then
		vim.cmd("write")
	end
	close_split()
	vim.wo.winbar = ""
	cleanup_bufs()
	state.active = false
	state.right_bufs = {}
	state.left_win = nil
	state.right_win = nil
	vim.keymap.del("n", "<Tab>")
	vim.keymap.del("n", "<S-Tab>")
	vim.keymap.del("n", "<leader>rl")
	vim.notify("Review ended")
end

---@param idx integer
local function review(idx)
	if vim.bo.modified then
		vim.cmd("write")
	end

	vim.o.diffopt = "internal,filler,algorithm:histogram"

	local entry = state.entries[idx]

	if wins_valid() then
		vim.api.nvim_set_current_win(state.left_win)
		vim.cmd("silent! diffoff")
		open_left_buf(entry)
		vim.api.nvim_set_current_win(state.right_win)
		vim.cmd("silent! diffoff")
	else
		close_split()
		open_left_buf(entry)
		state.left_win = vim.api.nvim_get_current_win()
		vim.cmd("rightbelow vnew")
		state.right_win = vim.api.nvim_get_current_win()
	end

	vim.api.nvim_win_set_buf(state.right_win, ensure_right_buf(entry, state.base, state.right_bufs))

	vim.api.nvim_set_current_win(state.left_win)
	vim.cmd("diffthis")
	vim.wo[state.left_win].foldenable = false

	vim.api.nvim_set_current_win(state.right_win)
	vim.cmd("diffthis")
	vim.wo[state.right_win].foldenable = false

	vim.api.nvim_set_current_win(state.left_win)
	local hunks = count_hunks()
	local hunk_str = hunks .. " change(s)"
	local tag = status_tag(entry)

	local meta_len = #hunk_str + #" | "
	for _, side in ipairs({
		{ win = state.left_win, branch = state.branch, file = entry.file },
		{ win = state.right_win, branch = state.base, file = entry.base_file or entry.file },
	}) do
		local pad = vim.fn.getwininfo(side.win)[1].textoff
		local width = vim.api.nvim_win_get_width(side.win)
		local path_budget = width - pad - #tag - meta_len - #side.branch - 2
		vim.wo[side.win].winbar =
			format_winbar(pad, tag, shorten_path(side.file, path_budget), hunk_str, side.branch, width)
	end

	vim.cmd("silent! normal! gg]c")

	state.current = idx
	local label = entry.status == "R" and (entry.base_file .. " → " .. entry.file) or entry.file
	vim.notify(string.format("[%d/%d] %s", idx, #state.entries, label))
end

-- Command

vim.api.nvim_create_user_command("ReviewBranchToggle", function(opts)
	if state.active then
		stop_review()
		return
	end

	local base = opts.fargs[1] or detect_base()
	if not base then
		vim.notify("No main/master branch found — pass a base explicitly", vim.log.levels.ERROR)
		return
	end

	local entries = get_diff_entries(base)
	if #entries == 0 then
		vim.notify("No changes vs " .. base, vim.log.levels.WARN)
		return
	end

	state = {
		entries = entries,
		current = 0,
		base = base,
		branch = current_branch(),
		active = true,
		right_bufs = {},
		left_win = nil,
		right_win = nil,
	}
	prefetch(base, entries)

	nnoremap("<Tab>", function()
		if state.current < #state.entries then
			review(state.current + 1)
		else
			vim.notify("Last file")
		end
	end, "Next review file")

	nnoremap("<S-Tab>", function()
		if state.current > 1 then
			review(state.current - 1)
		else
			vim.notify("First file")
		end
	end, "Previous review file")

	nnoremap("<leader>rl", function()
		local names = vim.tbl_map(function(e)
			return e.status == "R" and (e.base_file .. " → " .. e.file) or e.file
		end, state.entries)
		vim.ui.select(names, { prompt = "Changed files:" }, function(_, idx)
			if idx then
				review(idx)
			end
		end)
	end, "List review files")

	review(1)
end, {
	nargs = "?",
	complete = function()
		return vim.fn.systemlist("git branch --format='%(refname:short)'")
	end,
	desc = "Toggle branch review in side-by-side diff",
})
