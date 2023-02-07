return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local nnoremap = require("user.utils.keymap").nnoremap

			local show_nvim_config_files = function()
				require("telescope.builtin").find_files({ cwd = os.getenv("HOME") .. "/.config/nvim" })
			end
			nnoremap("<leader>m", show_nvim_config_files, "Show files in $HOME/.config/nvim")

			nnoremap("<leader>o", builtin.find_files, "Search files in the current working directory")
			nnoremap("<leader>gf", builtin.git_files, "Search files in the current git repository")

			-- Inside files
			nnoremap("<leader>s", builtin.current_buffer_fuzzy_find, "Fuzzy find in the current buffer")
			nnoremap("<leader>gg", builtin.live_grep, "Grep in all the files in current working directory")

			-- Git
			nnoremap("<leader>gc", builtin.git_commits, "Search git commits")
			nnoremap("<leader>gb", builtin.git_branches, "Search git branches")

			-- LSP
			nnoremap("<leader>w", builtin.lsp_document_symbols, "Search lsp symbols in the current file")
			nnoremap("<leader>W", builtin.lsp_workspace_symbols, "Search lsp symbols in the project")
			nnoremap("gR", builtin.lsp_references, "Show all references of the symbol under the cursor")

			-- Help
			nnoremap("<leader>H", builtin.help_tags, "Search nvim documentation")
			nnoremap("<leader>K", builtin.keymaps, "Seach all current keymaps")

			-- Other
			nnoremap("<leader>D", builtin.diagnostics, "Show all the diagnostics mesages in the project")
			nnoremap("<leader>b", builtin.buffers, "Show all opened buffers")
			nnoremap("<leader>q", builtin.quickfix, "Show current quickfix list")

			telescope.setup({
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
						"--trim", -- add this value
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_previous,
							["<C-k>"] = actions.move_selection_next,
							-- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-h>"] = "which_key",
							["<C-q>"] = function(bufnr)
								actions.smart_send_to_qflist(bufnr)
								builtin.quickfix()
							end,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }, -- requires fd to be installed (for e.g. `brew install fd`)
					},
					current_buffer_fuzzy_find = {
						theme = "cursor",
					},
				},
			})
		end,
	}, -- Highly exendable fuzzy finder over lists
	{
		"nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	-- TODO: uncomment
	-- {
	--   "nvim-telescope/telescope-fzf-native.nvim",
	--   config = function()
	--     require('telescope').load_extension('fzf')
	--   end,
	-- }, -- Sorter for telescope to improve performance
	{
		"ahmedkhalf/project.nvim",
		keys = {
      { "<leader>p", "<cmd>Telescope projects<cr>", desc = "Show all the projects" },
		},
		config = function()
			require("telescope").load_extension("projects")
			require("project_nvim").setup({
				manual_mode = false,
				detection_methods = { "lsp", "pattern" },
				patterns = {
					".metals",
					".git",
					"=tex",
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
				silent_chdir = true,
				scope_chdir = "global",
			})
		end,
	},
}
