return {
	{
		"iamcco/markdown-preview.nvim",
    event = "BufEnter *.md",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = { "markdown" },
	},
}
