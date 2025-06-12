return {
  "nvim-tree/nvim-tree.lua", -- file explorer
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>" },
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup({
      git = {
        timeout = 1000,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "toggleterm" },
      },
      view = {
        width = {},
      },
    })
  end,
}
