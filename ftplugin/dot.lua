-- Automatically compile and update preview.app on mac os
-- print("Entered dot file")
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = { "*.dot" },
--   callback = function()
--     local file = vim.fn.glob("%:p")
--     local file_folder = vim.fn.glob("%:h")
--     local file_to_save = file_folder .. "/" .. "output.png"
--     local prefresh = 'echo "tell application \"Preview\" to activate" | osascript -'
--     print(file_to_save)
--     vim.fn.jobstart("dot -Tpng '" .. file .. "'" .. "-o ".. file_to_save .. ";" .. prefresh)
--   end,
--   group = vim.api.nvim_create_augroup("Dot compile on save", { clear = true }),
-- })
