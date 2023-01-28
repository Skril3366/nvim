-- To add a colorscheme configure it and put into `colorschemes` table with key
-- as it's name
local colorscheme = require("user.config").colorscheme.name
local conf = require("user.config").colorscheme
local priority = 100 -- default one is 50, for colorschemes should be higher

local tokyonight = {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "night", -- `storm`, `night` or `day`
      transparent = conf.transparent_background,
      terminal_colors = true,
      styles = {
        comments = "italic",
        keywords = "italic",
        functions = "NONE",
        variables = "NONE",
        -- Backgrounds
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "lazy.nvim", "terminal", "packer", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}

local catppuccin = {
  "catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = conf.transparent_background,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}

local colorschemes = {
  ["catppuccin"] = catppuccin,
  ["tokyonight"] = tokyonight,
}

local chosen = colorschemes[colorscheme]
chosen.priority = priority -- To ensure that colorscheme loads first

return chosen
