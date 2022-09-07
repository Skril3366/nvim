local installer_status_ok, installer = pcall(require, 'mason')
if not installer_status_ok then
  print("LSPInstaller failed to run")
  return
end

local attach = function(client)
  print("LSP has started")
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
  on_attach = attach,
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT", path = vim.split(package.path, ';'), },
      completion = { keywordSnippet = "Disable", },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        diagnostics = { enable = true, globals = {
          "vim", "describe", "it", "before_each", "after_each" },
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file("", true),
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


config.jsonls.setup {on_attach = attach}

config.ltex.setup {on_attach = attach}
config.texlab.setup {on_attach = attach}

-- config.grammarly.setup { }
config.marksman.setup {
  on_attach = attach,
  -- single_file_support = true,
}
config.prosemd_lsp.setup {
  on_attach = attach,
  single_file_support = true,
}

config.gopls.setup {on_attach = attach}
config.golangci_lint_ls.setup {on_attach = attach}
config.cssls.setup {on_attach = attach}
config.bashls.setup {on_attach = attach}
config.ccls.setup {on_attach = attach}
config.clangd.setup {on_attach = attach}
config.sqls.setup {on_attach = attach}
config.sqlls.setup {on_attach = attach}
config.sqlls.setup {on_attach = attach}
-- config.pyls.setup {on_attach = attach}
config.pyright.setup {on_attach = attach}

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
