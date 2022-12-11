local ok, null_ls = pcall(require, "null-ls")

if not ok then
  print("Null-ls is not installed")
  return
end


local builtins = null_ls.builtins

local formatting = builtins.formatting
local formatting_sources = {
  formatting.scalafmt, -- scala
  formatting.beautysh, -- bash
  formatting.shfmt, -- bash

  formatting.black, -- python
  formatting.blue, -- python
  formatting.isort, -- python sort imports

  formatting.markdownlint, -- markdown
  formatting.remark, -- markdown

  formatting.stylua, -- lua

  formatting.clang_format, -- C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C#
  -- formatting.codespell, -- common misspelling checker (for e.g. adn instead and)
  formatting.prettierd, -- JavaScript, TypeScript, Flow, JSX, JSON, CSS, SCSS, LESS, HTML, Vue, Angular, GraphQL, Markdown, YAML
}

local diagnostics = builtins.diagnostics
local diagnostics_sources = {
  -- diagnostics.chktex,
  -- diagnostics.codespell, -- common misspelling checker (for e.g. adn instead and)
  -- diagnostics.cspell, -- spell checker for code
  -- diagnostics.flake8, -- python
  diagnostics.markdownlint, -- markdown
  diagnostics.misspell, -- correct commonly misspelled words
  -- diagnostics.pyproject_flake8, -- python
  diagnostics.shellcheck, -- bash
  diagnostics.vale, -- Text, Markdown, LaTeX
  diagnostics.vulture, -- python : find unused code
  -- diagnostics.markdownlint_cli2,
  -- diagnostics.luacheck,
  -- diagnostics.mdl,
  -- diagnostics.mypy,
  -- diagnostics.pycodestyle,
  -- diagnostics.pydocstyle,
  -- diagnostics.pylint,
  -- diagnostics.todo_comments,
}

local code_actions = builtins.code_actions
local code_actions_sources = {
  code_actions.cspell, -- spell checker for code
  code_actions.refactoring, -- automated refactoring
  code_actions.shellcheck, -- static analyzer for shell scripts
}

local sources = {}
local addSources = function(s)
  for _, v in ipairs(s) do
    table.insert(sources, v)
  end
end

addSources(formatting_sources)
addSources(diagnostics_sources)
addSources(code_actions_sources)

null_ls.setup({
  sources = sources,
  debug = true,
})
