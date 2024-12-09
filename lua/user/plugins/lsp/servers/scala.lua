local should_set_up_scala = require("user.config").lsp.additionally_set_up.scala

if should_set_up_scala then
  return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    keys = {
      {
        "<leader>x",
        "<cmd>Telescope metals commands<cr>",
        desc = "Show all metals commands",
      },
    },
    config = function(self, metals_config)
      local nvim_metals_group =
          vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
    opts = function()
      local metals = require("metals")
      local metals_config = metals.bare_config()
      metals_config.settings = {
        showImplicitArguments = true,
        superMethodLensesEnabled = true,
        showInferredType = true,
        showImplicitConversionsAndClasses = true,
        testUserInterface = "Test Explorer",
        fallbackScalaVersion = "2.13.10",
        -- serverVersion = "1.3.3", -- this is the last version that supports scala 2.13.10
      }

      metals_config.on_attach = function(_, _)
        metals.setup_dap()
      end

      metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = { prefix = "" } }
      )

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      metals_config.capabilities =
          require("cmp_nvim_lsp").default_capabilities(capabilities)

      metals.initialize_or_attach(metals_config)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "scala",
          "sbt",
          "java",
        },
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
      })
    end,
  }
end
