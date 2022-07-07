local keymap = vim.keymap.set
local opts = {
  noremap = true, silent = true
}
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- Telescope
local telescope = require("telescope.builtin")
keymap("n", "<leader>m", function() telescope.find_files(
    { cwd = os.getenv("HOME") .. "/.config/nvim" })
end, opts)
keymap("n", "<leader>o", telescope.find_files, opts)
keymap("n", "<leader>b", telescope.buffers, opts)
keymap("n", "<leader>s", telescope.current_buffer_fuzzy_find, opts)
keymap("n", "<leader>gg", telescope.live_grep, opts)
keymap("n", "<leader>gf", telescope.git_files, opts)
keymap("n", "<leader>gc", telescope.git_commits, opts)
keymap("n", "<leader>gb", telescope.git_branches, opts)
keymap("n", "gR", telescope.lsp_references, opts)
keymap("n", "gw", telescope.lsp_workspace_symbols, opts)
keymap("n", "gw", telescope.lsp_type_definitions, opts)
keymap("n", "<leader>H", telescope.help_tags, opts)
keymap("n", "<leader>K", telescope.keymaps, opts)

-- LSP
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
keymap("n", "<leader>f", function() buf.formatting_sync(nil, 100) end, opts)
keymap("n", "<leader>a", buf.code_action, opts)
keymap("n", "gd", buf.definition, opts)
keymap("n", "gD", buf.declaration, opts)
keymap("n", "gi", buf.implementation, opts)
keymap("n", "K", buf.hover, opts)
keymap("n", "gr", buf.rename, opts)
keymap("n", "gdn", diagnostic.goto_prev, opts)
keymap("n", "gdp", diagnostic.goto_next, opts)
keymap("n", "<leader>d", diagnostic.open_float, opts)

-- Other
keymap("n", "<leader>u", '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>', opts)

keymap("n", "<leader>c", '<cmd>!pdflatex %<cr>', opts)

-- Vimtex
-- keymap("<leader>li", vim.cmd("<plug>(vimtex-info)"), opts)
-- keymap("<leader>ll", vim.cmd("<plug>(vimtex-compile)"), opts)
