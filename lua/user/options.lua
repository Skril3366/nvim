-- Aliases
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Line numbers
o.relativenumber = true -- relative line numbers
o.nu = true -- display current line number

-- TABs
o.tabstop = 8 -- number of spaces that form 1 tab. Should be 8 by default
o.softtabstop = 2 -- number of spaces that form 1 tab
o.shiftwidth = 2 -- number of spaces that form 1 tab
o.expandtab = true -- insert spaces instead of tabs in insert mode

-- Folding
wo.foldmethod="expr" -- default fold method as expression
o.foldexpr="nvim_treesitter#foldexpr()" -- tree sitter foldmethod
o.foldlevelstart=99
wo.foldlevel=99

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
-- o.textwidth = 80 -- automatically breaks the line if it's longer than 80 symbols

-- Other
o.autoread = true -- update file when it's changed
o.autochdir = true -- automatically change working directory
o.hidden = true -- don't unload buffers
o.lazyredraw = true -- don't update buffer while executing commands
o.swapfile = false -- don't create swap file

-- Filetype specific

vim.cmd([[
autocmd FileType markdown,tex setlocal spell
autocmd FileType markdown,tex setlocal textwidth=80
]])
