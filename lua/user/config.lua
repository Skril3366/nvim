return {
  enabled_plugins = {
    copilot = true,
  },
  colorscheme = {
    name = "tokyonight",
    transparent_background = true,
  },
  lsp = {
    -- enable additional plugins for better language support
    additionally_set_up = {
      rust = true,
      scala = true,
    },
    -- list of lsp servers to be install
    ensure_installed = {
      lsp = {
        "bashls",
        "clangd",
        "cssls",
        "jdtls",
        "jsonls",
        "lua_ls",
        "marksman",
        "texlab",
        "yamlls",
        "rust_analyzer",
      },
      dap = {
        "bash-debug-adapter",
        "cpptools",
        "java-debug-adapter",
        "java-test",
      },
      null_ls = {
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
        "misspell",
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
      },
    },
  },
}
