-------------------------------------------------------------------------------
----------------------- Custom keybindings  -----------------------------------
-------------------------------------------------------------------------------

vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = {
	noremap = true,
	silent = true,
}

------------------------------- LSP -------------------------------------------
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
keymap("n", "<leader>f", function()
	buf.format()
end, opts)
keymap("n", "<leader>a", buf.code_action, opts)
keymap("n", "gd", buf.definition, opts)
keymap("n", "gD", buf.declaration, opts)
keymap("n", "gi", buf.implementation, opts)
keymap("n", "K", buf.hover, opts)
keymap("n", "gr", buf.rename, opts)
keymap("n", "<leader>dp", diagnostic.goto_prev, opts)
keymap("n", "<leader>dn", diagnostic.goto_next, opts)
keymap("n", "<leader>d", diagnostic.open_float, opts)

------------------------------- Telescope --------------------------------------
local tb_ok, telescope_builtin = pcall(require, "telescope.builtin")

local t_ok, telescope = pcall(require, "telescope")

if not tb_ok and not t_ok then
	print("Telescope is not installed")
else
	local find_config_files = function()
		telescope_builtin.find_files({ cwd = os.getenv("HOME") .. "/.config/nvim" })
	end
	-- Files
	keymap("n", "<leader>m", find_config_files, opts)
	keymap("n", "<leader>o", telescope_builtin.find_files, opts)
	keymap("n", "<leader>gf", telescope_builtin.git_files, opts)

  -- function to check if root directory is git repo
  local is_git_repo = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    return git_dir and #git_dir > 0 and git_dir or nil
  end

	-- Inside files
	keymap("n", "<leader>s", telescope_builtin.current_buffer_fuzzy_find, opts)
	keymap("n", "<leader>gg", telescope_builtin.live_grep, opts)

	-- Git
	keymap("n", "<leader>gc", telescope_builtin.git_commits, opts)
	keymap("n", "<leader>gb", telescope_builtin.git_branches, opts)

	-- LSP
	keymap("n", "<leader>w", telescope_builtin.lsp_document_symbols, opts)
	keymap("n", "gR", telescope_builtin.lsp_references, opts)

	-- Help
	keymap("n", "<leader>H", telescope_builtin.help_tags, opts)
	keymap("n", "<leader>K", telescope_builtin.keymaps, opts)

	-- Other
	keymap("n", "<leader>D", telescope_builtin.diagnostics, opts)
	keymap("n", "<leader>b", telescope_builtin.buffers, opts)
	keymap("n", "<leader>M", "<cmd>Telescope harpoon marks<cr>", opts)

	-- Project
	-- telescope.load_extension("projects")
	local ok, _ = pcall(telescope.load_extension, "projects")
	if not ok then
		print("Project is not installed")
	else
		keymap("n", "<leader>p", "<cmd>Telescope projects<cr>", opts)
	end

	local ok, _ = pcall(telescope.load_extension, "orgmode")
	if not ok then
		print("Org mode telescope extension is not installed")
	else
		local org_opts = {
			noremap = opts.noremap,
			silent = opts.silent,
			buffer = vim.api.nvim_get_current_buf(),
		}
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.org", "orgagenda" },
			callback = function()
				keymap("n", "<leader>oh", "<cmd>Telescope orgmode search_heading<cr>", org_opts)
				keymap("n", "<leader>or", "<cmd>Telescope orgmode refile_heading<cr>", org_opts)
				print("Orgmode loaded")
			end,
		})
	end

	local ok, _ = pcall(require, "todo-comments")
	if not ok then
		print("Todo comments plugin is not installed")
	else
		keymap("n", "<leader>T", "<cmd>TodoTelescope<cr>", opts)
	end
end

------------------------------ Harpoon -----------------------------------------
local hm_ok, harpoon_mark = pcall(require, "harpoon.mark")
local hu_ok, harpoon_ui = pcall(require, "harpoon.ui")

if not (hm_ok or hu_ok) then
	print("Harpoon is not installed")
else
	keymap("n", "<leader>h", harpoon_mark.add_file, opts)
	keymap("n", "<leader>U", harpoon_ui.toggle_quick_menu, opts)
	keymap("n", "<leader>n", function()
		harpoon_ui.nav_file(1)
	end, opts)
	keymap("n", "<leader>e", function()
		harpoon_ui.nav_file(2)
	end, opts)
	keymap("n", "<leader>t", function()
		harpoon_ui.nav_file(3)
	end, opts)
end

------------------------------- DAP -------------------------------------------
local ok, dap = pcall(require, "dap")

if not ok then
	print("Dap is not installed")
else
	-- Steps
	keymap("n", "<leader>dc", dap.continue, opts)
	keymap("n", "<leader>di", dap.step_into, opts)
	keymap("n", "<leader>dO", dap.step_out, opts)
	keymap("n", "<leader>do", dap.step_over, opts)

	-- Breakpoints
	local conditional_breakpoint = function()
		dap.toggle_breakpoint(vim.fn.input("Condition: "))
	end
	keymap("n", "<leader>dB", conditional_breakpoint, opts)
	keymap("n", "<leader>db", dap.toggle_breakpoint, opts)

	-- Other
	keymap("n", "<leader>dt", dap.terminate, opts)

	-- UI
	local ok, dapui = pcall(require, "dapui")
	if not ok then
		print("DapUI is not installed")
	else
		keymap("n", "<leader>du", dapui.toggle, opts)
	end
end

------------------------------- LuaSnip ---------------------------------------
local ok, luasnip = pcall(require, "luasnip")

if not ok then
	print("LuaSnip is not installed")
else
	keymap({ "i", "s" }, "<C-k>", function()
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end, opts)
	keymap({ "i", "s" }, "<C-j>", function()
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end, opts)
	keymap({ "i", "s" }, "<C-l>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, opts)
end

------------------------------- NvimTree ---------------------------------------

local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok then
	print("NvimTree is not installed")
else
	keymap("n", "<leader>t", function()
		nvim_tree.toggle()
	end, opts)
end

------------------------------- Other -----------------------------------------
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>", opts)
keymap("n", "<leader>i", "<cmd>cd %:p:h<cr>", opts)
-- keymap("n", "<leader>t", function ()
--     vim.cmd("vimgrep /\<TODO\>/j **/*.*")
--     vim.cmd("scope")
-- end, opts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "latex", "tex" },
	callback = function()
		keymap("n", "<leader>c", "<cmd>!pdflatex %<cr>", opts)
	end,
})

---------------------------- Compile and run ----------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		keymap("n", "<leader>c", "<cmd>!go run .<cr>", opts)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*.cpp" },
	callback = function()
		keymap("n", "<leader>c", "!g++ %; ./a.out", opts)
	end,
})
