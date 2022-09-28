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
keymap("n", "<leader>H", telescope.help_tags, opts)
keymap("n", "<leader>K", telescope.keymaps, opts)
keymap("n", "<leader>w", telescope.lsp_document_symbols, opts)
keymap("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", opts)

-- LSP
local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
keymap("n", "<leader>f", function() buf.format(nil, 100) end, opts)
keymap("n", "<leader>a", buf.code_action, opts)
keymap("n", "gd", buf.definition, opts)
keymap("n", "gD", buf.declaration, opts)
keymap("n", "gi", buf.implementation, opts)
keymap("n", "K", buf.hover, opts)
keymap("n", "gr", buf.rename, opts)
keymap("n", "<leader>dn", diagnostic.goto_prev, opts)
keymap("n", "<leader>dp", diagnostic.goto_next, opts)
keymap("n", "<leader>d", diagnostic.open_float, opts)


-- DAP
local dap = require('dap')
keymap("n", "<leader>dc", dap.continue, opts)
keymap("n", "<leader>dB", function() dap.toggle_breakpoint(vim.fn.input('Condition: ')) end, opts)
keymap("n", "<leader>db", dap.toggle_breakpoint, opts)
keymap("n", "<leader>di", dap.step_into, opts)
keymap("n", "<leader>dO", dap.step_out, opts)
keymap("n", "<leader>do", dap.step_over, opts)
keymap("n", "<leader>dt", dap.terminate, opts)
keymap("n", "<leader>du", require('dapui').toggle, opts)

--Luasnip
local ls = require('luasnip')
keymap({"i", "s"}, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end,
    opts)
keymap({"i", "s"}, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end,
    opts)
keymap({"i", "s"}, "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end,
    opts)

-- Other
keymap("n", "<leader>u", '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>', opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "latex", "tex" },
  callback = function()
    keymap("n", "<leader>c", '<cmd>!pdflatex %<cr>', opts)
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    keymap("n", "<leader>c", '<cmd>!go run .<cr>', opts)
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.cpp" },
  callback = function()
    keymap("n", "<leader>c", '!g++ %; ./a.out', opts)
  end
})

-- Vimtex
-- keymap("<leader>li", vim.cmd("<plug>(vimtex-info)"), opts)
-- keymap("<leader>ll", vim.cmd("<plug>(vimtex-compile)"), opts)
--
--
--
--
