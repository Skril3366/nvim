local ok, null_ls = pcall(require, "null-ls")

if not ok then
    print("Null-ls is not installed")
    return
end

local builtins = null_ls.builtins

local sources = {
    builtins.formatting.stylua,
    builtins.formatting.prettier.with({
        filetypes = { "html", "json", "yaml", "markdown", "latex" },
    }
    ),

}
null_ls.setup({
    sources = sources,
})
