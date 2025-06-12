return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    {
      "<leader>dd",
      "<cmd>TroubleToggle<cr>",
      desc = "Toggle NvimTrouble plugin",
    },
  },
  config = function()
    require("trouble").setup({})
  end,
}
