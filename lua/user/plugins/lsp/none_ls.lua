return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local b = null_ls.builtins

    local sources = {
      -- Formatting
      b.formatting.scalafmt,
      b.formatting.shfmt,
      b.formatting.black,
      b.formatting.isort,
      b.formatting.stylua,
      b.formatting.clang_format,
      b.formatting.prettierd,
      b.formatting.google_java_format,
      {
        name = "ocamlfmt",
        method = null_ls.methods.FORMATTING,
        filetypes = { "ocaml" },
        generator = null_ls.generator({
          command = "ocamlfmt",
          to_stdin = true,
        }),
      },
      b.formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" },
      }),
      {
        name = "ormolu",
        method = null_ls.methods.FORMATTING,
        filetypes = { "haskell" },
        generator = null_ls.generator({
          command = "ormolu",
          to_stdin = true,
        }),
      },

      -- Diagnostics
      b.diagnostics.ktlint.with({
        rgs = {
          "--relative",
          "--reporter=json",
          "**/*.kt",
          "**/*.kts",
        },
      }),
      b.diagnostics.vale,
      b.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "postgres" },
      }),

      -- Code Actions
      b.code_actions.refactoring,
    }

    null_ls.setup({
      sources = sources,
      debug = false,
    })
  end,
}
