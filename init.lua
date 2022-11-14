local user = "user."

local colorschemes = user .. "colorschemes."
local core = user .. "core."

local plugins = user .. "plugins."
local lsp = plugins .. "lsp."

require(plugins .. "plugins")

require(core .. "options")
require(core .. "keybindings")

require(colorschemes .. "tokyonight")

require(plugins .. "lualine")
require(plugins .. "luasnip")
require(plugins .. "nvim-tree")
require(plugins .. "treesitter")
require(plugins .. "telescope")
require(plugins .. "toggleterm")
require(plugins .. "orgmode")
require(plugins .. "project")

require(lsp .. "cmp")
require(lsp .. "dap")
require(lsp .. "mason")
require(lsp .. "null-ls")
