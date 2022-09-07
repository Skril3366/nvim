-- Aliases
local o = vim.o
local wo = vim.wo
local bo = vim.bo


-- Line numbers
o.relativenumber = true -- relative line numbers
o.nu = true -- display current line number

-- TABs
o.tabstop = 4 -- number of spaces that form 1 tab. Should be 8 by default
o.softtabstop = 4 -- number of spaces that form 1 tab
o.shiftwidth = 4 -- number of spaces that form 1 tab
o.expandtab = true -- insert spaces instead of tabs in insert mode

-- Folding
wo.foldmethod = "expr" -- default fold method as expression
-- vim.api.nvim_win_set_option(0, 'foldmethod', 'expr')
-- vim.api.nvim_win_set_option(0, 'foldexpr', 'nvim_treesitter#foldexpr()')
wo.foldexpr = "nvim_treesitter#foldexpr()" -- tree sitter foldmethod
-- vim.cmd("setlocal foldexpr=nvim_treesitter#foldexpr()")
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern="*",
--   callback = function ()
--     vim.cmd("setlocal foldexpr=nvim_treesitter#foldexpr()")
--   end
-- })
o.foldlevelstart = 99
wo.foldlevel = 99

-- Undo & Backup
o.undofile = true -- enable saving history
o.undodir = os.getenv("HOME") .. "/.config/nvim/undodir" -- save undo history there
o.backup = false -- don't create backup file while writing changes

-- Searching
o.incsearch = true -- show search results as you type
o.smartcase = true -- if all letters are lowercase then any case, otherwise perfect match
o.hlsearch = false -- disable highlighting after searching

-- UI
o.showtabline = 2
o.showmode = true
wo.cursorline = true -- cursorline
o.colorcolumn = "80" -- column

o.splitbelow = true -- change horizontal splits to open below
o.splitright = true -- change vertical splits to open on the right
o.laststatus = 2 -- show 1 statusline for the last window

o.termguicolors = true -- enable termguicolors
wo.wrap = false -- disable text wrapping
o.errorbells = false -- disable error bells
o.scrolloff = 8 -- show 8 lines below cursor while scrolling
wo.signcolumn = "yes:2" -- automatically set column for signs
-- o.wildmenu = true -- ????
o.textwidth = 80 -- automatically breaks the line if it's longer than 80 symbols

-- Other
o.autoread = true -- update file when it's changed
-- o.autochdir = true -- automatically change working directory
o.hidden = true -- don't unload buffers
o.lazyredraw = true -- don't update buffer while executing commands
o.swapfile = false -- don't create swap file
o.filetype = true -- enable filetype detection


-- Filetype specific

vim.cmd([[
autocmd FileType * setlocal spell
]])

-- local spell_group = vim.api.nvim_create_augroup("Set spell", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = spell_group,
--   pattern = { "*.tex", "*.md", "*.txt" },
--   callback = function()
--     vim.cmd("setlocal spell")
--     -- vim.cmd("setlocal textwidth=80")
--   end
-- })
