-- Only files that provide core functionality are required in this file
-- Settings files for additional plugins are required in plugins.lua
-- LSP settings specific to languages are in lua/user/lsp forlder and required
-- in lsp.lua

require("user.plugins") -- Plugin manager and plugin installation
require("user.options") -- Native options

require("user.keybindings") -- All the keybindings

require("user.telescope") -- Plugin settings for telescope
require("user.toggleterm") -- Plugin settings for terminal inside neovim

require("user.cmp") -- Completion Engine
require("user.luasnip") -- Snippets
require("user.lsp") -- Language Server Protocol + LSP, DAP and lineter install manager
require("user.dap") -- Debugging Adapter Protocol

require("user.nvim-tree") -- File explorer inside NeoVim
require("user.null-ls")
