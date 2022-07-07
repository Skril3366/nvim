local installer_status_ok, installer = pcall(require, 'nvim-lsp-installer')
if not installer_status_ok then
  print("LSPInstaller failed to run")
  return
end

installer.setup({
  ensure_installed = {
    'sumneko_lua',
    -- 'clangd', 'ccls',
    -- 'grammarly',
    'marksman', 'prosemd_lsp',
    'ltex', 'texlab',
    'jsonls',
    'gopls', 'golangci_lint_ls'
  },
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

local config_status_ok, config = pcall(require, 'lspconfig')
if not config_status_ok then
  print("LSPConfig failed to run")
  return
end

config.sumneko_lua.setup {
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
config.jsonls.setup {}

config.ltex.setup {}
config.texlab.setup {}

-- config.grammarly.setup { }
config.marksman.setup {
  -- single_file_support = true,
}
config.prosemd_lsp.setup {
  single_file_support = true,
}

config.gopls.setup {}
config.golangci_lint_ls.setup {}

-- require('lspconfig').clangd.setup{}
-- require('lspconfig').ccls.setup{}

-- require('lspconfig').hls.setup {
--     on_attach = custom_on_attach,
--     capabilities = capabilities,
--     single_file_support = true,
--     settings = {
--         haskell = {
--             hlintOn = false,
--         }
--     }
-- }
