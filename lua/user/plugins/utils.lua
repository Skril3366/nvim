return {
  {
    -- Read binary files as hex
    "RaafatTurki/hex.nvim",
    lazy = true,
    event = { "BufRead *.out" },
    config = function()
      require("hex").setup()
    end,
  },
}
