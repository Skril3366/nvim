-- Configure lazygit so that editing a file in lazygit opens it in a new tab
vim.fn.setenv("VISUAL", "nvr --nostart --remote-tab-wait +'set bufhidden=delete'")
