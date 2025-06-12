return {
  "norcalli/nvim-colorizer.lua", -- display hex colors
  config = function()
    require("colorizer").setup({
      "css",
      "javascript",
      "lua",
    }, { mode = "background" })
  end,
}
