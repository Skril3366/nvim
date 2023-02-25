local buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local lsp_servers = (...):match("(.-)[^%.]+$") .. "servers."

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
          local mason = require("mason")
          mason.setup({})

          -- Set virtual text support
          vim.lsp.handlers["textDocument/publishDiagnostics"] =
              vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        lazy = false,
        -- TODO: rewrite this into config function
        keys = {
            { "<leader>f",  buf.format },
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

          vim.api.nvim_create_autocmd({ "BufEnter" }, {
              callback = function()
                vim.cmd("LspStart")
              end,
          })

          masonlsp.setup({
              ensure_installed = {
                  "bashls",
                  "clangd",
                  "cssls",
                  "jdtls",
                  "jsonls",
                  "lua_ls",
                  "marksman",
                  "prosemd_lsp",
                  "remark_ls",
                  "texlab",
                  "yamlls",
              },
          })
          local attach = function(_)
            print("LSP has started")
          end

          -- Settings for LSPs
          masonlsp.setup_handlers({
              function(server_name) -- default handler
                require("lspconfig")[server_name].setup({ on_attach = attach })
              end,
              -- Server specific handlers
              ["lua_ls"] = function(_)
                require("lspconfig").lua_ls.setup(require(lsp_servers .. "lua"))
              end,
              ["jdtls"] = function(_)
                -- Empty function not to run it from Mason
              end,
              ["bashls"] = function(_)
                require("lspconfig").bashls.setup({
                    on_attach = attach,
                    filetypes = { "sh", "zsh", "zshrc" },
                })
              end,
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
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
          local masonnull = require("mason-null-ls")
          masonnull.setup({
              ensure_installed = {
                  "beautysh",
                  "black",
                  "blue",
                  "clang-format",
                  "cmakelang",
                  "codespell",
                  "cpplint",
                  "cspell",
                  -- "flake8",
                  "golangci-lint",
                  "isort",
                  "markdownlint",
                  "misspell",
                  "prettierd",
                  -- "pyproject-flake8",
                  "remark-cli",
                  "selene",
                  "shellcheck",
                  "shfmt",
                  "stylua",
                  "textlint",
                  "vale",
                  -- "vulture",
                  "write-good",
                  "yamlfmt",
                  "yamllint",
              },
          })
        end,
    },
}
