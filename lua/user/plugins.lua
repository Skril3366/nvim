-------------------------------------------------------------------------------
------------ "Packer" plugin manager installation and set up ------------------
------------- see https://github.com/wbthomason/packer.nvim -------------------
-------------------------------------------------------------------------------

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
end

vim.cmd [[packadd packer.nvim]]

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
    use {
        'wbthomason/packer.nvim', -- Have packer manage itself
        'nvim-lua/popup.nvim', -- An implementation of the Popup API
        'nvim-lua/plenary.nvim', -- Useful lua functions used ny lots of plugins
        'kyazdani42/nvim-web-devicons', -- Pretty dev icons for other plugin usage
    }

    -- Fun
    use 'mbbill/undotree' -- Undotree visual representation
    -- use 'ThePrimeagen/vim-be-good'

    -- Customization
    use {
        'folke/tokyonight.nvim', -- Colorscheme
        config = function()
            require("user.tokyonight")
        end
    }
    use {
        'nvim-lualine/lualine.nvim', -- Status and tab lines
        config = function()
            require("user.lualine")
        end
    }


    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', -- Highly exendable fuzzy finder over lists
        'nvim-telescope/telescope-dap.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', -- Sorter for telescope to improve performance
            run = 'make' },
    }

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter', -- User-friendly interface and basic functionality for TreeSitter
        config = function()
            require("user.treesitter")
        end
    }
    use { -- Different modules for TreeSitter
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-context', -- Show current context as top line
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground', -- TS information viewer
        'p00f/nvim-ts-rainbow', -- Rainbow parentheses
    }

    -- NOTE: in neovim 0.8.0 it will be built in feature
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }
    use {
        'm-demare/hlargs.nvim', -- highlighting arguments of functions
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('hlargs').setup()
        end
    }

    -- LSP
    use 'onsails/lspkind.nvim' -- VScode-like pictograms for built in lsp
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }
    use({ 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim' } })

    -- DAP
    use {
        'mfussenegger/nvim-dap',
        'leoluz/nvim-dap-go',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
    }

    -- Other
    use { 'akinsho/toggleterm.nvim', tag = 'v2.*', config = function()
        require('toggleterm').setup()
    end }
    -- use 'tpope/vim-commentary' -- commenting code in any language
    -- use {
    --   'kylechui/nvim-surround', -- (surrouning text)
    --   config = function()
    --     require('nvim-surround').setup({
    --       -- Configuration here, or leave empty to use defaults
    --     })
    --   end
    -- }
    -- use 'frabjous/knap' -- Plugin for markdown and latex preview
    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.surround').setup({})
            require('mini.comment').setup({})
            require('mini.indentscope').setup({})
            require('mini.pairs').setup({})
            require('mini.trailspace').setup({})
        end
    }

    -- Snippets and Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'KadoBOT/cmp-plugins',
                config = function()
                    require('cmp-plugins').setup({
                        files = { 'plugins.lua', os.getenv('HOME') .. '/.config/nvim/lua/user/plugins.lua' } -- Recommended: use static filenames or partial paths
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
    use {
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    }


    -- .conf filetype support
    use 'satabin/hocon-vim'
    -- install without yarn or npm
    use({ 'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' },
    })
    -- Packer
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Harpoon
    use {
        'ThePrimeagen/harpoon',
        config = function()
            require('harpoon').setup({})
        end
    }

    -- Plugin for integrating with browser extention https://github.com/glacambre/firenvim
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
