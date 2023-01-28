local M = {}

local opts = {
  noremap = true,
  silent = true,
}

M.keymap = function(mode, binding, action, desc)
  local lopts = opts
  lopts.desc = desc
  vim.keymap.set(mode, binding, action, lopts)
end

M.nnoremap = function(binding, action, desc)
  M.keymap("n", binding, action, desc)
end

return M
