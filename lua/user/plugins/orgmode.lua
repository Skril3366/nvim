-- init.lua

local ok, orgmode = pcall(require, "orgmode")
if not ok then
  print("Orgmode is not installed")
  return
end

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()

local org_todo_entry = function(keyword, binding, color)
  return {
    keyword = keyword,
    color = color,
    binding = binding,
  }
end

local colors = {
  white = "#FFFFFF",
  yellow = "#E5C07B",
  purple = "#C678DD",
  gray = "#5C6370",
  green = "#98C379",
  orange = "#FF9E64",
}

local ok, tokyonight_colors = pcall(require, "tokyonight.colors")
if ok then
  local c = tokyonight_colors.setup()
  colors.white = string.upper(c.fg)
  colors.yellow = string.upper(c.yellow)
  colors.purple = string.upper(c.purple)
  colors.gray = string.upper(c.terminal_black)
  colors.green = string.upper(c.green)
  colors.orange = string.upper(c.orange)
end

local all_todo_keywords = {
  org_todo_entry("INBOX", "i", colors.white),
  org_todo_entry("RELEVANT", "r", colors.purple),
  org_todo_entry("SOMEDAY", "s", colors.orange),
  org_todo_entry("NOTES", "n", colors.green),
  org_todo_entry("CONTENT", "c", colors.orange),
  org_todo_entry("WAITING", "w", colors.purple),
  org_todo_entry("PROJECTS", "p", colors.green),
  org_todo_entry("QUICK_ACTIONS", "q", colors.yellow),
  org_todo_entry("TODO", "t", colors.yellow),
}

local all_done_keywords = {
  org_todo_entry("DONE", "d", colors.gray),
  org_todo_entry("TRASH", "x", colors.gray),
}

local keywords_with_bindings = function(todo_keywords, done_keywords)
  local result = {}
  for _, keyword in ipairs(todo_keywords) do
    table.insert(result, keyword.keyword .. "(" .. keyword.binding .. ")")
  end
  table.insert(result, "|")
  for _, keyword in ipairs(done_keywords) do
    table.insert(result, keyword.keyword .. "(" .. keyword.binding .. ")")
  end
  return result
end

local keywords_with_colors = function(todo_keywords, done_keywords)
  local result = {}
  -- local all_keywords = vim.tbl_extend("force", todo_keywords, done_keywords)
  for _, keyword in ipairs(todo_keywords) do
    result[keyword.keyword] = ":foreground " .. keyword.color
  end
  for _, keyword in ipairs(done_keywords) do
    result[keyword.keyword] = ":foreground " .. keyword.color
  end
  return result
end

orgmode.setup({
  org_agenda_files = { "~/Personal Library/Org/*" },
  org_default_notes_file = "~/Personal Library/Org/Desktop.org",
  org_todo_keywords = keywords_with_bindings(all_todo_keywords, all_done_keywords),
  org_todo_keyword_faces = keywords_with_colors(all_todo_keywords, all_done_keywords),
  org_archive_location = "~/Personal Library/Org/Archive.org",
  org_agenda_start_with_log_mode = true,
  org_log_done = "time",
  mappings = {
    global = {
      org_agenda = "<leader>A",
      org_capture = "<leader>C",
    },
  },
})
