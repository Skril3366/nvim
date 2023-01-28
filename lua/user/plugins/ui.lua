return {
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 0, -- &winblend for the window
					zindex = nil, -- the zindex value for the window
					border = "none",
				},
			})
		end,
	},
	"kyazdani42/nvim-web-devicons", -- beautiful icons
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>" },
		},
	}, -- ui for undo history
	"onsails/lspkind.nvim", -- vscode-like pictograms for lsp completion items
	{
		"nvim-lualine/lualine.nvim", -- status line
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
					globalstatus = false,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = {},
					lualine_b = { "buffers" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua", -- file explorer
		keys = {
			{ "<leader>t", "<cmd>NvimTreeToggle<cr>" },
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				git = {
					ignore = false,
				},
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
		end,
	},
	{
		"lewis6991/gitsigns.nvim", -- show git changes
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua", -- display hex colors
		config = function()
			require("colorizer").setup({
				"css",
				"javascript",
				"lua",
			}, { mode = "background" })
		end,
	},
	{
		"folke/todo-comments.nvim",
    lazy = false, --needed to highlight keywords in editor
		keys = {
			{ "<leader>T", "<cmd>TodoTelescope<cr>" },
		},
		config = function()
			require("todo-comments").setup({})
		end,
	},
}
