vim.api.nvim_create_user_command("HexEdit", function()
	vim.cmd[[
	 set ft=xxd
	 %!xxd
	 ]]
end, { nargs = 0, desc = "Edit file in HEX mode" })

vim.api.nvim_create_user_command("HexDone", function()
	vim.cmd[[
	 set ft=""
	 %!xxd -r
	 ]]
end, { nargs = 0, desc = "Revert file back from HEX mode to normal encoding" })
