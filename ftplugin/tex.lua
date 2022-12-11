-- Automatically compile latex file on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.tex" },
  callback = function()
    local file = vim.fn.glob("%:p")
    vim.fn.jobstart("pdflatex '" .. file .. "'")
  end,
  group = vim.api.nvim_create_augroup("Latex Compile On Save", { clear = true }),
})

print("Loaded tex.lua")

vim.cmd([[
let g:vimtex_view_method = 'zathura'
let g:vimtex_format_enabled = 1
]])
