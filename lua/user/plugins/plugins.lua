-------------------------------------------------------------------------------
------------ "Packer" plugin manager installation and set up ------------------
------------- see https://github.com/wbthomason/packer.nvim -------------------
-------------------------------------------------------------------------------

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
end

vim.cmd([[packadd packer.nvim]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer is not installed")
  return
end

-- Reload neovim whenever you save the plugins.lua file
local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  callback = function()
    vim.cmd("source %")
    packer.sync()
  end,
  group = packer_user_config,
})

-- Have packer use a popup window
packer.init({
  ensure_dependencies = true,
  auto_clean = true,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Utils
  use({
    "wbthomason/packer.nvim", -- Have packer manage itself
    "nvim-lua/popup.nvim", -- An implementation of the Popup API
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    "kyazdani42/nvim-web-devicons", -- Pretty dev icons for other plugin usage
  })

  -- Fun
  use("mbbill/undotree") -- Undotree visual representation
  use("ThePrimeagen/vim-be-good")
  use("tjdevries/train.nvim")

  -- Customization
  use({
    "folke/tokyonight.nvim", -- Colorscheme
    config = function()
      require("user.colorschemes.tokyonight")
    end,
  })

  use("David-Kunz/markid")

  -- use {
  --     'morhetz/gruvbox',
  --     config = function()
  --         require("user.colorschemes.gruvbox")
  --     end
  -- }
  use({
    "nvim-lualine/lualine.nvim", -- Status and tab lines
    -- config = function()
    -- 	require("user.lualine")
    -- end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim", -- Highly exendable fuzzy finder over lists
    "nvim-telescope/telescope-dap.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim", -- Sorter for telescope to improve performance
      run = "make",
    },
  })

  -- TreeSitter
  use({
    "nvim-treesitter/nvim-treesitter", -- User-friendly interface and basic functionality for TreeSitter
    -- config = function()
    -- 	require("user.treesitter")
    -- end,
  })
  use({ -- Different modules for TreeSitter
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-context", -- Show current context as top line
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground", -- TS information viewer
    "p00f/nvim-ts-rainbow", -- Rainbow parentheses
  })

  use({
    "m-demare/hlargs.nvim", -- highlighting arguments of functions
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
    end,
  })

  -- LSP
  use("onsails/lspkind.nvim") -- VScode-like pictograms for built in lsp
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-nvim-dap.nvim",
    "jayp0521/mason-null-ls.nvim",
    "neovim/nvim-lspconfig",
  })
  use("jose-elias-alvarez/null-ls.nvim")
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        window = {
          relative = "editor", -- where to anchor, either "win" or "editor"
          blend = 0, -- &winblend for the window
          zindex = nil, -- the zindex value for the window
          border = "none", -- style of border for the fidget window
        },
      })
    end,
  })
  -- Scala
  use("scalameta/nvim-metals")
  -- Java
  use("mfussenegger/nvim-jdtls")

  -- DAP
  use({
    "mfussenegger/nvim-dap",
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  })
  -- Latex
  use("lervag/vimtex")

  -- Other
  use({
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = function()
      require("toggleterm").setup()
    end,
  })
  use({
    "echasnovski/mini.nvim",
    config = function()
      -- require("mini.surround").setup({})
      require("mini.comment").setup({})
      require("mini.indentscope").setup({})
      require("mini.pairs").setup({})
      require("mini.trailspace").setup({})
    end,
  })

  --   Old text                    Command         New text
  -- --------------------------------------------------------------------------------
  --     surr*ound_words             ysiw)           (surround_words)
  --     *make strings               ys$"            "make strings"
  --     [delete ar*ound me!]        ds]             delete around me!
  --     remove <b>HTML t*ags</b>    dst             remove HTML tags
  --     'change quot*es'            cs'"            "change quotes"
  --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  --     delete(functi*on calls)     dsf             function calls
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })

  -- Snippets and Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      {
        "KadoBOT/cmp-plugins",
        config = function()
          require("cmp-plugins").setup({
            files = { "plugins.lua", os.getenv("HOME") .. "/.config/nvim/lua/user/plugins.lua" }, -- Recommended: use static filenames or partial paths
          })
        end,
      },
      { "davidsierradz/cmp-conventionalcommits" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      { "jc-doyle/cmp-pandoc-references" },
      { "ray-x/cmp-treesitter" },
      { "saadparwaiz1/cmp_luasnip" },
      { "uga-rosa/cmp-dictionary" },
      { "vappolinario/cmp-clippy" },
    },
  })

  -- TODO: setup this engine
  use({
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  })

  -- .conf filetype support
  use("satabin/hocon-vim")
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  -- Packer
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

  -- Harpoon
  use({
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup({})
    end,
  })

  -- Display hex colors
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "css",
        "javascript",
      }, { mode = "background" })
    end,
  })

  -- Plugin for integrating with browser extention https://github.com/glacambre/firenvim
  use({
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  })

  -- File explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })
  -- Project managenet
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
  })

  -- refactoring for null-ls
  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
