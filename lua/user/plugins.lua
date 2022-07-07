local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer is not installed")
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_user_config_id = vim.api.nvim_create_augroup("packer_user_config", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, { group = packer_user_config_id,
  callback = function()
    vim.api.nvim_del_augroup_by_id(packer_user_config_id)
    require('plugins')
    packer.sync()
  end })

-- Have packer use a popup window
packer.init {
  ensure_dependencies = true,
  auto_clean          = true,
  display             = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Utils
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use 'kyazdani42/nvim-web-devicons' -- Pretty dev icons for other plugin usage
  -- use 'tjdevries/complextras'

  -- Fun
  use "mbbill/undotree" -- Undotree visual representation

  -- Customization
  use 'folke/tokyonight.nvim' -- Colorscheme
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'onsails/lspkind.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim', -- Sorter for telescope to improve performance
    run = 'make'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- TreeSitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = "TSUpdate"
  }
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    'p00f/nvim-ts-rainbow',
    requires = { { 'nvim-treesitter/nvim-treesitter' } }
  }
  use {
    'm-demare/hlargs.nvim', -- highlighting arguments of functions
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup()
    end
  }

  -- LSP
  use {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  }

  -- Other
  -- use 'tpope/vim-commentary' -- commenting code in any language
  -- use {
  --   "kylechui/nvim-surround", -- (surrouning text)
  --   config = function()
  --     require("nvim-surround").setup({
  --       -- Configuration here, or leave empty to use defaults
  --     })
  --   end
  -- }
  -- use 'frabjous/knap' -- Plugin for markdown and latex preview
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      -- require('mini.comment').setup()
      -- require('mini.indentscope').setup()
      require('mini.pairs').setup()
      require('mini.trailspace').setup()
    end
  }

  -- Snippets and Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'KadoBOT/cmp-plugins',
        config = function()
          require("cmp-plugins").setup({
            files = { "plugins.lua", os.getenv("HOME") .. "/.config/nvim/lua/user/plugins.lua" } -- Recommended: use static filenames or partial paths
          })
        end },
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'jc-doyle/cmp-pandoc-references' },
      { 'ray-x/cmp-treesitter' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'uga-rosa/cmp-dictionary' },
      { 'vappolinario/cmp-clippy' },
    }
  }

  -- TODO: setup this engine
  use 'L3MON4D3/LuaSnip' -- Snippets engine 
  -- install without yarn or npm

  use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
