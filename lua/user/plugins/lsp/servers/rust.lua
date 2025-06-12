return {
  "simrat39/rust-tools.nvim",
  event = "BufEnter *.rs, Cargo.toml",
  config = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          rt.inlay_hints.enable()
        end,
      },
    })
  end,
}
