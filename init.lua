local user = "user."

local load = function(name)
  local ok, mod = pcall(require, user .. name)
  if not ok then
    error("Failed to load module " .. name .. ": " .. mod)
  end
  return mod
end

load("core.options")
load("core.lazygit")
load("core.keybindings")


load("lazy") -- load auto-installer for lazy.nvim
require("lazy").setup(user .. "plugins")
