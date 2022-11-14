local ok, project_nvim = pcall(require, "project_nvim")

if not ok then
	print("Project.nvim is not installed")
	return
end

project_nvim.setup({
	manual_mode = false,
	detection_methods = { "lsp", "pattern" },
	patterns = {
		"=src",
		".git",
		"_darcs",
		".hg",
		".bzr",
		".svn",
		"Makefile",
		"package.json",
	},
	exclude_dirs = { os.getenv("HOME") },
	show_hidden = false,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	silent_chdir = false,
	scope_chdir = "global",
})
