return {
  "mrcjkb/haskell-tools.nvim",
  version = "^4",
  lazy = false,
  ft = { "haskell", "lhaskell", "cabal" },
  init = function()
    vim.g.haskell_tools = {
      hls = {
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
        end,
        settings = {
          haskell = {
            formattingProvider = "ormolu",
            plugin = { ["hls-semantic-tokens-plugin"] = { globalOn = true } },
          },
        },
      },
    }
  end,
}
