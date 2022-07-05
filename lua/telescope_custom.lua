local telescope_custom={}

function telescope_custom.find_notes()
  require('telescope.builtin').live_grep{
    promt_title="\\ Notes /",
    cwd="~/Documents/Obsidian/General",
    layout_stategy="horizontal",
    layout_config={
        preview_width=0.65,
        },
    }
end

return telescope_custom
