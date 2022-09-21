local ls = require("luasnip")
local types = require("luasnip.util.types")
-- require("luasnip.loaders.from_vscode").lazy_load()
-- require'luasnip'.filetype_extend("ruby", {"rails"})
ls.config.set_config{
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"<-", "Error"}},
            },
        },
    }
}

-- local snippets_path = '~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/latex/latex-snippets.json'
-- local snippets_path = vim.fn.stdpath "data" .. '/site/pack/packer/start/friendly-snippets',
-- require("luasnip.loaders.from_vscode").load({
--   paths = { snippets_path, },
--     include = {"c"},
-- })
require("luasnip.loaders.from_vscode").lazy_load()

-- local s = ls.s
-- local i = ls.insert_node
-- local t = ls.text_node
--
-- ls.add_snippets("all", {
--     s("ternary", {
--         -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
--         i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
--     })
-- })
--
--
