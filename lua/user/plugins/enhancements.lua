return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup({}) -- add comments by shortcut
			require("mini.ai").setup({ -- extend around/inside text objects
				custom_textobjects = nil,
				mappings = {
					-- Main textobject prefixes
					around = "a",
					inside = "i",
					-- Next/last variants
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",
					-- Move cursor to corresponding edge of `a` textobject
					goto_left = "g[",
					goto_right = "g]",
				},
				-- Number of lines within which textobject is searched
				n_lines = 100,
				search_method = "cover_or_next",
			})
			require("mini.pairs").setup({}) -- auto pair brackets and quotes
			require("mini.trailspace").setup({}) -- highlight and remove trailing spaces
		end,
	},
	{
		"kylechui/nvim-surround", -- surround text by objects
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			local nnoremap = require("user.utils.keymap").nnoremap

			nnoremap("<leader>h", mark.add_file, "Add file to Harpoon list")
			nnoremap("<leader>U", ui.toggle_quick_menu, "Toggle Harpoon quick menu")

			local nav1 = function()
				ui.nav_file(1)
			end
			local nav2 = function()
				ui.nav_file(2)
			end
			local nav3 = function()
				ui.nav_file(3)
			end

			nnoremap("<leader>n", nav1, "Open 1st file from Harpoon")
			nnoremap("<leader>e", nav2, "Open 2nd file from Harpoon")
			nnoremap("<leader>i", nav3, "Open 3rd file from Harpoon")
		end,
	},
}
