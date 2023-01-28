-------------------------------------------------------------------------------
------------------------ Setting up Metals for Scala --------------------------
------------- see https://github.com/ ------------------
-------------------------------------------------------------------------------
return {
  "scalameta/nvim-metals",
  event = "BufEnter *.scala",
  keys = {
    { "<leader>x", "<cmd>Telescope metals commands<cr>", desc= "Show all metals commands"  },
  },
  config = function()
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      superMethodLensesEnabled = true,
      showInferredType = true,
      showImplicitConversionsAndClasses = true,
      fallbackScalaVersion = "3.2.0",
    }

    metals_config.on_attach = function(_, _)
      require("metals").setup_dap()
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "scala",
        "sbt",
        -- "java"
      },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
    })
    metals_config.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = { prefix = "" } })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    -- require("telescope").extensions.metals.commands()
  end,
}
