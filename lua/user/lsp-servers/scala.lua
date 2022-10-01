-------------------------------------------------------------------------------
------------------------ Setting up Metals for Scala --------------------------
------------- see https://github.com/scalameta/nvim-metals ------------------
-------------------------------------------------------------------------------

local metals_config = require("metals").bare_config()

metals_config.settings = {
    showImplicitArguments = true,
}

metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
