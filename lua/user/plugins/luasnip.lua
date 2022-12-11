local ok, luasnip = pcall(require, "luasnip")
if not ok then
    print("Lua snip filed to run")
    return
end

local types = require("luasnip.util.types")

luasnip.config.set_config{
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

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.snippets")
