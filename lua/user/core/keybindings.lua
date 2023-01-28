vim.g.mapleader = " "

local nnoremap = require("user.utils.keymap").nnoremap

nnoremap("]q", "<cmd>cnext<cr>", "Go to the next item in quickfix list")
nnoremap("[q", "<cmd>cprev<cr>", "Go to the previous item in quickfix list")
nnoremap("dq", "<cmd>call setqflist([])<cr>", "Clean quickfix list")

