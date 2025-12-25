local buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local lsp_servers = (...):match("(.-)[^%.]+$") .. "servers."

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({})

      -- Set virtual text support
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = true }
      )
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          buf.format({ async = true })
        end,
      },
      { "<leader>a",  buf.code_action },
      { "gd",         buf.definition },
      { "gD",         buf.declaration },
      { "gi",         buf.implementation },
      { "K",          buf.hover },
      { "gr",         buf.rename },
      { "<leader>dp", diagnostic.goto_prev },
      { "<leader>dn", diagnostic.goto_next },
      { "<leader>d",  diagnostic.open_float },
    },
    config = function()
      local masonlsp = require("mason-lspconfig")
      -- Fixes an issue that LSPs are sometimes not started when opening a file
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          vim.cmd("LspStart")
        end,
      })

      local attach = function(_)
        print("LSP has started")
      end

      masonlsp.setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cssls",
          "jdtls",
          "jsonls",
          "lua_ls",
          "texlab",
          "yamlls",
          "rust_analyzer",
        },
        automatic_installation = false,
        upgrade = {
          filter = function(package)
            if package:match("^ktlint@") then
              return false
            end
            return true
          end,
        },
        handlers = {
          -- Default handler
          function(server_name)
            require("lspconfig")[server_name].setup({ on_attach = attach })
          end,

          -- Server-specific handlers
          ["kotlin_language_server"] = function()
            require("lspconfig").kotlin_language_server.setup({
              on_attach = function(client, _)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider =
                    false
                attach(client)
              end,
            })
          end,

          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup(require(lsp_servers .. "lua"))
          end,

          ["pyright"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.util.add_hook_before(
              lspconfig.util.on_setup,
              function(config)
                print("Pyright before init")
                local Path = require("plenary.path")
                local venv =
                    Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")

                if venv:joinpath("bin"):is_dir() then
                  config.settings.python.pythonPath =
                      tostring(venv:joinpath("bin", "python"))
                  print(
                    "Using virtual environment: "
                    .. config.settings.python.pythonPath
                  )
                else
                  print("No virtual environment found")
                end
              end
            )
            require("lspconfig").pyright.setup({ on_attach = attach })
          end,

          ["jdtls"] = function()
            -- Empty function to exclude from Mason management
          end,

          ["bashls"] = function()
            require("lspconfig").bashls.setup({
              on_attach = attach,
              filetypes = { "sh", "zsh", "zshrc" },
            })
          end,

          ["ocamllsp"] = function()
            require("lspconfig").ocamllsp.setup({
              on_attach = attach,
            })
          end,
        },
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      local masondap = require("mason-nvim-dap")
      masondap.setup({
        ensure_installed = {
          "bash-debug-adapter",
          "cpptools",
          "java-debug-adapter",
          "java-test",
        },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local masonnull = require("mason-null-ls")
      masonnull.setup({
        ensure_installed = {
          "protolint",
          "beautysh",
          "black",
          "blue",
          "clang-format",
          "cmakelang",
          "codespell",
          "cpplint",
          "cspell",
          "golangci-lint",
          "isort",
          "ltex-ls",
          "prettierd",
          "selene",
          "shellcheck",
          "shfmt",
          "stylua",
          "textlint",
          "vale",
          "write-good",
          "yamlfmt",
          "yamllint",
          "google_java_format",
          "sql_formatter",
          "sqlfluff",
          "latexindent",
          "gdtoolkit",
        },
        automatic_installation = true,
      })
    end,
  },
}
