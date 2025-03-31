local should_set_up_scala = require("user.config").lsp.additionally_set_up.scala

local metals_loaded = function()
  if vim.fn.exists(":MetalsConnectBuild") == 2 then
    print(vim.fn.exists(":MetalsConnectBuild"))
    return true
  end
  return false
end

local init_metals = function(metals)
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
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = { prefix = "" } }
    )
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  metals_config.capabilities =
      require("cmp_nvim_lsp").default_capabilities(capabilities)
  return metals_config
end

if should_set_up_scala then
  return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    keys = {
      {
        "<leader>x", -- NOTE: to start metals in scala file you should trigger this shortcut, otherwise it won't start automatically
        function()
          local async = require("plenary.async")
          async.run(function()
            local metals = require("metals")
            local metals_config = init_metals(metals)
            metals.initialize_or_attach(metals_config)
            vim.wait(2000, metals_loaded)
            vim.cmd("Telescope metals commands")
          end)
        end,
        desc = "Show all metals commands",
      },
    },
    config = function()
      local metals = require("metals")
      init_metals(metals)
    end,
  }
end
