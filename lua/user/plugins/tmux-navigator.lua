return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    local nnoremap = require("user.utils.keymap").nnoremap
    nnoremap("<C-w>h", [[<Cmd>TmuxNavigateLeft<CR>]])
    nnoremap("<C-w>l", [[<Cmd>TmuxNavigateRight<CR>]])
    nnoremap("<C-w>j", [[<Cmd>TmuxNavigateDown<CR>]])
    nnoremap("<C-w>k", [[<Cmd>TmuxNavigateUp<CR>]])
  end,
}
