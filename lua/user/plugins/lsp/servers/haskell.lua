return {
  "mrcjkb/haskell-tools.nvim",
  version = "^4",
  lazy = false,
  ft = { "haskell", "lhaskell", "cabal" },
  init = function()
    local ht = require("haskell-tools")

    -- Suggested keymaps
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Hoogle Search (The feature you want)
    -- This requires 'telescope.nvim'
    vim.keymap.set("n", "<leader>h", ht.hoogle.hoogle_signature, opts)

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
