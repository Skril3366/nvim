local ok, telescope = pcall(require, 'telescope')
if not ok then
    print("Telescope is not installed")
    return
end

telescope.setup {
    defaults = {
        prompt_prefix = "",
        vimgrep_arguments = {
            "rg", -- requires ripgrep to be installed (for e.g. `brew install ripgrep`)
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
        },
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }, -- requires fd to be installed (for e.g. `brew install fd`)
            -- theme = "cursor",
            -- previewer = "previewers.cat.new",
        },
        current_buffer_fuzzy_find = {
            theme = "cursor",
        },
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

local ok, fzf = pcall(telescope.load_extension, 'fzf')
if not ok then
    print("Could not load telescope fzf extension")
    return
end

local ok, fzf = pcall(telescope.load_extension, 'harpoon')
if not ok then
    print("Could not load telescope harpoon extension")
    return
end
