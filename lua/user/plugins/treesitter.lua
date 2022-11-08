local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("Tree sitter failed to run")
  return
end

configs.setup({
  ensure_installed = {
    "cpp",
    "c",
    "lua",
    "go",
    "scala",
    -- Scripting languages
    "bash",
    -- Markup languages
    "yaml",
    "latex",
    "json",
    "markdown",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    -- smart_rename = {
    --   enable = true,
    --   keymaps = { smart_rename = "gr" },
    -- },
    navigation = {
      enable = false,
      -- keymaps = {
      --     -- goto_definition = "gd",
      --     list_definitions = "gnD",
      --     list_definitions_toc = "gO",
      -- },
    },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})

local status_ok, spellsitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("Spell sitter is not installed")
else
  spellsitter.setup({
    -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
    enable = true,
    debug = false,
  })
end

local spellsitter_group = vim.api.nvim_create_augroup("spellsitter", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embeded terminal
  command = "setlocal nospell",
  group = spellsitter_group,
})

require("treesitter-context").setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      "class",
      "function",
      "method",
      "for",
      "while",
      "if",
      "switch",
      "case",
    },
    -- Patterns for specific filetypes
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    tex = {
      "chapter",
      "section",
      "subsection",
      "subsubsection",
    },
    rust = {
      "impl_item",
      "struct",
      "enum",
    },
    scala = {
      "object_definition",
    },
    vhdl = {
      "process_statement",
      "architecture_body",
      "entity_declaration",
    },
    markdown = {
      "section",
    },
    elixir = {
      "anonymous_function",
      "arguments",
      "block",
      "do_block",
      "list",
      "map",
      "tuple",
      "quoted_content",
    },
    json = {
      "pair",
    },
    yaml = {
      "block_mapping_pair",
    },
  },
  exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
    -- rust = true,
  },

  -- [!] The options below are exposed but shouldn't require your attention,
  --     you can safely ignore them.

  zindex = 20, -- The Z-index of the context window
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  markid = { enable = true },
})

local status_ok, markid = pcall(require, "markid")
if not status_ok then
  print("Markid is not installed")
  return
end

local markid_colors = {
  medium = {
    "#2ac3de",
    "#73daca",
    "#7aa2f7",
    "#7dcfff",
    -- '#9ece6a',
    "#b4f9f8",
    "#bb9af7",
    "#e0af68",
    "#f7768e",
    "#ff9e64",
  },
  -- bright = { "#f5c0c0", "#f5d3c0", "#f5eac0", "#dff5c0", "#c0f5c8", "#c0f5f1", "#c0dbf5", "#ccc0f5", "#f2c0f5",
  --     "#98fc03" },
  -- dark = { "#c99d9d", "#c9a99d", "#c9b79d", "#c9c39d", "#bdc99d", "#a9c99d", "#9dc9b6", "#9dc2c9", "#9da9c9",
  --     "#b29dc9" }
}

require("nvim-treesitter.configs").setup({
  markid = {
    enable = true,
    colors = markid_colors.medium,
    queries = markid.queries,
    is_supported = function(lang)
      local queries = configs.get_module("markid").queries
      return pcall(vim.treesitter.parse_query, lang, queries[lang] or queries["default"])
    end,
  },
})
