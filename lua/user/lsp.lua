-- local configs = require 'lspconfig.configs'
-- local util = require 'lspconfig.util'
-- if not configs.prolog_lsp then
--   configs.prolog_lsp = {
--     default_config = {
--       cmd = {"swipl",
--              "-g", "use_module(library(lsp_server)).",
--              "-g", "lsp_server:main",
--              "-t", "halt",
--              "--", "stdio"};
--       filetypes = {"prolog"};
--       root_dir = util.root_pattern("pack.pl");
--     };
--   }
-- end
-- require'lspconfig'.prolog_lsp.setup{on_attach = attach}
--
local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
    print("Mason failed to run")
    return
end


local masonlspconfig_status_ok, masonlsp = pcall(require, 'mason-lspconfig')
if not masonlspconfig_status_ok then
    print("LSPConfig failed to run")
    return
end

mason.setup()
masonlsp.setup()

local attach = function(client)
    print("LSP has started")
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = true,
    }
)

require("mason-lspconfig").setup_handlers {
    function(server_name) -- default handler
        require("lspconfig")[server_name].setup { on_attach = attach }
    end,
    -- Server specific handlers
    ["sumneko_lua"] = function()
        require("lspconfig").sumneko_lua.setup {
            on_attach = attach,
            filetypes = { "lua" },
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT", path = vim.split(package.path, ';'),
                    },
                    completion = { keywordSnippet = "Disable", },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        diagnostics = { enable = true, globals = {
                            "vim", "describe", "it", "before_each", "after_each"
                        },
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
    end
}



local metals_config = require("metals").bare_config()

metals_config.settings = {
    showImplicitArguments = true,
    -- excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
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
