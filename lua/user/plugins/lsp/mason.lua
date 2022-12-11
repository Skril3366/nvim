-------------------------------------------------------------------------------
--------- Setting up lsp, dap and linter server manager "Mason" ---------------
------------- see https://github.com/williamboman/mason.nvim ------------------
-------------------------------------------------------------------------------

local ok, mason = pcall(require, "mason")
if not ok then
	print("Mason failed to run")
	return
end

mason.setup()

local ok, masonlsp = pcall(require, "mason-lspconfig")
if not ok then
	print("Mason Lsp config failed to run")
	return
end

local ok, mason_dap = pcall(require, "mason-nvim-dap")
if not ok then
	print("Mason nvim dap failed to run")
	return
end

mason_dap.setup({
	ensure_installed = {
		"bash-debug-adapter",
		"cpptools",
		"java-debug-adapter",
		"java-test",
	},
})

local lsp_servers = "user.plugins.lsp.lsp-servers."

-- TODO: add servers here
masonlsp.setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"cssls",
		"jdtls",
		"jsonls",
		"sumneko_lua",
		"marksman",
		"prosemd_lsp",
		"remark_ls",
		"texlab",
		"yamlls",
	},
})

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
	print("Mason null-ls failed to run")
	return
end

mason_null_ls.setup({
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

-- General on_attach function for LSP servers
local attach = function(client)
	print("LSP has started")
end

-- Settings for LSPs
masonlsp.setup_handlers({
	function(server_name) -- default handler
		require("lspconfig")[server_name].setup({ on_attach = attach })
	end,
	-- Server specific handlers
	["sumneko_lua"] = function()
		require("lspconfig").sumneko_lua.setup(require(lsp_servers .. "lua"))
	end,
	["jdtls"] = function()
		-- Empty function not to run it from Mason
	end,
	["bashls"] = function()
		require("lspconfig").bashls.setup({
			on_attach = attach,
			filetypes = { "sh", "zsh", "zshrc" },
		})
	end,
})

require(lsp_servers .. "scala")

-------------------------------------------------------------------------------
----------------------------- Other LSP settings ------------------------------
-------------------------------------------------------------------------------

-- Set virtual text support
vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })
