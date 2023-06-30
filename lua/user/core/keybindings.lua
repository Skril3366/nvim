vim.g.mapleader = " "

local nnoremap = require("user.utils.keymap").nnoremap
local vnoremap = require("user.utils.keymap").vnoremap

nnoremap("]q", "<cmd>cnext<cr>", "Go to the next item in quickfix list")
nnoremap("[q", "<cmd>cprev<cr>", "Go to the previous item in quickfix list")
nnoremap("dq", "<cmd>call setqflist([])<cr>", "Clean quickfix list")
nnoremap("dq", "<cmd>call setqflist([])<cr>", "Clean quickfix list")
vnoremap("<leader>p", '"_dP', "paste without cutting")

nnoremap("<c-f>", function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
end, "Copy relative file path to clipboard")
