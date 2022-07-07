vim.opt.completeopt = { "menu", "menuone", "noselect" }


-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"


-- Complextras.nvim configuration
-- vim.api.nvim_set_keymap(
--   "i",
--   "<C-x><C-m>",
--   [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
--   { noremap = true }
-- )

-- vim.api.nvim_set_keymap(
--   "i",
--   "<C-x><C-d>",
--   [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
--   { noremap = true }
-- )

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  print("CMP failed to run")
  return
end

-- cmp.setup.cmdline('/', {
--   sources = cmp.config.sources(
--     { { name = 'nvim_lsp_document_symbol' } },
--     { { name = 'buffer' } }

--   )
-- })

-- cmp.setup.cmdline(":", {
--   completion = {
--     autocomplete = false,
--   },

--   sources = cmp.config.sources({
--     {
--       name = "path",
--     },
--   }, {
--     {
--       name = "cmdline",
--       max_item_count = 20,
--       keyword_length = 4,
--     },
--   }),
-- })


cmp.setup {
  ignored_filetypes = {
    TelescopePrompt = true
  },
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
    end
  end,

  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    -- ["<tab>"] = false,
    ["<tab>"] = cmp.config.disable,
  },

  sources = {
    -- { name = 'cmp-clippy',
    --   options = {
    --     model = "EleutherAI/gpt-neo-2.7B", -- check code clippy vscode repo for options
    --     key = "", -- huggingface.co api key
    --   } },
    { name = 'nvim_lua' },
    { name = "plugins" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "dictionary" },
    { name = "pandoc_references" },
    { name = "conventionalcommits" },
    { name = "path" },
    { name = "luasnip" },
    { name = "calc" },
    { name = "buffer", keyword_length = 5 },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        treesitter = "[TS]",
        pandoc_references = "[pandoc]",
        dictionary = "[dict]",
        calc = "[calc]",
        conventionalcommits = "[commits]",
        nvim_lua = "[api]",
        plugins = "[Plugins]",
        nvim_lsp = "[LSP]",
        buffer = "[buf]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },

  sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- Youtube: mention that you need a separate snippets plugin
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },


  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
}

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "lua",
--   callback = function()
--     cmp.setup.buffer {
--       sources = {
--         { name = 'nvim_lua' },
--         { name = "nvim_lsp_signature_help" },
--         { name = "nvim_lsp" },
--         { name = "treesitter" },
--         { name = "dictionary" },
--         { name = "path" },
--         { name = "luasnip" },
--         { name = "calc" },
--         { name = "buffer", keyword_length = 5 },
--       },
--     }
--   end
-- })


-- Add vim-dadbod-completion in sql files
-- _ = vim.cmd [[
--   augroup DadbodSql
--     au!
--     autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
--   augroup END
-- ]]

-- _ = vim.cmd [[
--   augroup CmpZsh
--     au!
--     autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
--   augroup END
-- ]]

--[[
" Disable cmp for a buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]

-- Youtube: customizing appearance
--
-- nvim-cmp highlight groups.
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles

-- Group.new("CmpItemAbbr", g.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)
