return {
  {
    "echasnovski/mini.trailspace",
    config = function()
      local trailspace = require("mini.trailspace")
      trailspace.setup() -- highlight and remove trailing spaces
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        callback = function()
          trailspace.trim()
          trailspace.trim_last_lines()
        end,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    config = function()
      require("mini.pairs").setup() -- auto pair brackets and quotes
    end,
  },
  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup() -- auto pair brackets and quotes
    end,
  },
}
