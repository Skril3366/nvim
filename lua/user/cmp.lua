-------------------------------------------------------------------------------
------------------ Settings for completion  -----------------------------------
--------------- see https://github.com/onsails/lspkind.nvim -------------------
--------------- and https://github.com/hrsh7th/nvim-cmp -----------------------
-------------------------------------------------------------------------------

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

cmp.setup {
    ignored_filetypes = {
        TelescopePrompt = false,
    },
    enabled = function()
        -- disable completion in comments
        if vim.bo.buftype == 'prompt' then
            return false
        end

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
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
        ["<tab>"] = cmp.config.disable,
    },

    sources = {
        { name = "luasnip" },
        { name = 'nvim_lua' },
        { name = "plugins" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "treesitter" },
        { name = "dictionary" },
        { name = "pandoc_references" },
        { name = "conventionalcommits" },
        { name = "path" },
        { name = "calc" },
        { name = "buffer", keyword_length = 5 },
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                luasnip = "[snip]",
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
            },
        },
    },

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

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

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },


    experimental = {
        native_menu = false,
        ghost_text = true,
    },
}
