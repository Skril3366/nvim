local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
    print("NvimTree failed to run")
    return
end

nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        width = 10,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    respect_buf_cwd = true,
    -- sync_root_with_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },

})
