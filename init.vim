 " Fixing tabs
 set foldmethod=expr
 set foldexpr=nvim_treesitter#foldexpr()
 set foldlevelstart=99
 " set foldlevel=99



 set tabstop=2 softtabstop=2 shiftwidth=2
 set smartindent
 set cindent

 set nowrap

 " Line numbers
 set relativenumber
 set nu


 set cursorline
 set colorcolumn=80

 set autoread
 set autochdir
 set hidden

 set incsearch
 set ignorecase
 set smartcase

 set lazyredraw
 set nobackup
 set noerrorbells
 set nohlsearch
 set noswapfile
 set scrolloff=8
 set signcolumn=yes
 set splitbelow splitright
 set termguicolors
 set undofile
 set wildmenu

 set undodir=~/.config/nvim/undodir
 " Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'vimoutliner/vimoutliner'

Plug 'ThePrimeagen/vim-be-good'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

Plug 'ghifarit53/tokyonight-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'hrsh7th/nvim-compe'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'mbbill/undotree'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'markonm/traces.vim' " Plugin for subtitute representation in real time

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }


Plug 'Raimondi/delimitMate' " Insert pairing brackets
" Plug 'junegunn/goyo.vim'
Plug 'folke/zen-mode.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ray-x/lsp_signature.nvim'
Plug 'L3MON4D3/LuaSnip'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Plug 'SirVer/ultisnips'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    " let g:vimtex_view_method='open'
    let g:vimtex_quickfix_mode=0
Plug 'Yggdroot/indentLine'

" Plug 'mfussenegger/nvim-jdtls'

Plug 'dpelle/vim-LanguageTool' " AI for checking texts

Plug 'ThePrimeagen/harpoon'

" Plug 'nvim-orgmode/orgmode'
" Plug 'akinsho/flutter-tools.nvim'
Plug 'neovimhaskell/haskell-vim'

Plug 'voldikss/vim-floaterm'

Plug 'nvim'

call plug#end()

" Theming
let g:tokyonight_transparent_background=1
let g:airline#extensions#tabline#enabled = 1

colorscheme tokyonight

" enable tabline

set showtabline=2
set noshowmode

" Key Maps
let mapleader="\<Space>"

nmap <leader>m :e $MYVIMRC<CR>
nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z



nnoremap <leader>o <cmd>Telescope find_files<cr>
" nnoremap <leader>gg <cmd>Telescope git_file<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>s <cmd>Telescope grep_string<cr>
nnoremap <leader>s <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap gR <cmd>Telescope lsp_references<cr>
nnoremap <leader>w <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap gt <cmd>Telescope lsp_type_definitions<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gg <cmd>Telescope live_grep<cr>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>ld <cmd>Telescope lsp_workspace_diagnostics<cr>
"nnoremap <leader>h <cmd>Telescope help_tags<cr>

" xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

autocmd FileType haskell set expandtab


nnoremap <leader>u <cmd>UndotreeToggle<CR> <cmd>UndotreeFocus<cr>
autocmd FileType markdown,tex setlocal spell
autocmd FileType cpp nnoremap <leader>c :w<cr><cmd>split<cr><cmd>terminal g++ -g -std=c++17 "%"; ./a.out<cr>a
autocmd FileType haskell nnoremap <leader>c :w<cr><cmd>split<cr><cmd>terminal ghc %; ./%:r<cr>a
autocmd FileType haskell nnoremap <leader>v :w<cr><cmd>split<cr><cmd>terminal stack build && stack run<cr>a
"autocmd FileType c nnoremap <leader>c <cmd>split<cr><cmd>terminal gcc -Wall -g "%"; ./a.out<cr>a
autocmd FileType c nnoremap <leader>c <cmd>split<cr><cmd>terminal gcc "%"; ./a.out<cr>a
"au BufRead *.java setf java
autocmd FileType java nnoremap <leader>c <cmd>split<cr><cmd>terminal javac *.java; java "%"<cr>a
"autocmd FileType java nnoremap <leader>c <cmd>split<cr><cmd>terminal javac "%"; java -cp %:p:h %:t:r<cr>a
autocmd FileType python nnoremap <leader>c :w<cr><cmd>split<cr><cmd>terminal python3 "%"<cr>a
" autocmd FileType python nnoremap <leader>d <cmd>split<cr><cmd>terminal python3 init.py<cr>a
autocmd FileType lua nnoremap <leader>c <cmd>split<cr><cmd>terminal lua "%"<cr>a
autocmd FileType verilog nnoremap <leader>c <cmd>split<cr><cmd>terminal iverilog -o dump "%"; vvp dump %<cr>a
autocmd FileType dart nnoremap <leader>c <cmd>split<cr><cmd>terminal dart "%"<cr>a
autocmd FileType tex nnoremap <leader>c <cmd>split<cr><cmd>terminal pdflatex %; bibtex %; pdflatex %; pdflatex %<cr>a

autocmd FileType vim nnoremap <leader>c <cmd>so "%"<cr>

" autocmd BufRead,BufNewFile *.md setlocal spell
" autocmd BufRead,BufNewFile *.tex setlocal spell
" autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespaces on save

nnoremap <leader>x :Cheat c

"VIMTEX--------------------

nmap <leader>li <plug>(vimtex-info)
nmap <leader>ll <plug>(vimtex-compile)
" LSP

" let g:LanguageClient_serverCommands = {
"   \ 'cpp': ['clangd'],
"   \ }
" lua require('lspconfig').clangd.setup{…}

" let g:LanguageClient_serverCommands = {
"     \ 'sh': ['bash-language-server']
"     \ }
" lua require('lspconfig').bashls.setup{…}


" lua << EOF
"   require("flutter-tools").setup{} -- use defaults
" EOF

lua <<EOF
require('lspconfig').hls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities,
				single_file_support = true,
        settings = {
            haskell = {
                hlintOn = false,
            }
        }
    }
EOF

lua <<EOF
local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  --"pyright",
  "clangd",
  "jsonls",
  "yamlls",
	"ltex",
	"grammarly",
	"vimls",
}


for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end
EOF

" lua require('lspconfig').pylsp.setup{}
" lua require('lspconfig').jsonls.setup{}
" lua require('lspconfig').bashls.setup{}
" lua require('lspconfig').diagnosticls.setup{}

" augroup lsp
" 	au!
" 	au FileType java lua require('jdtls').start_or_attach({cmd = {'launch_jdtls.sh'}})
" augroup end

lua << EOF

require('lspconfig')['pyright'].setup{
	filetypes = { "markdown", "latex"}
}
EOF



nnoremap <silent> <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gn <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> gp <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
nnoremap <silent> <leader>ns <cmd>lua require('telescope_custom').find_notes()<cr>

"--- COMPE and lsp
luafile ~/.config/nvim/lua/lsp/compe.lua
source ~/.config/nvim/plugconf/signify.vim

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
"---

nnoremap <silent> <leader>gs <cmd>G<CR>

let g:vsnip_filetypes = {}


"--- Commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>


"--- Harpoon
nnoremap <leader>h :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>i :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>

" This auto command formats tex file so the length of lines is consistent
" autocmd BufWritePre *.tex g/./ normal gqq
"
"

" Orgmode
lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

--require('orgmode').setup({
  --org_agenda_files = {'~/Documents/Org/Lists/*'},
  --org_todo_keywords = {'INBOX','PROJECTS', 'SOMEDAY', 'TODO', 'WAITING', 'CALENDAR', '|', 'DONE', 'CANCELLED',},
  --org_default_notes_file = '~/Documents/Org/Lists/Desktop.org',
--})
EOF

" Save fold level for each file
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent loadview
" augroup END

lua << EOF
local lsp_installer = require "nvim-lsp-installer"

local function on_attach(client, bufnr)
  -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
end


lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {
    on_attach = on_attach,
  }


  server:setup(opts)
end)

EOF

augroup remember_folds
  autocmd!
	autocmd BufWinLeave *.* mkview!
	autocmd BufWinEnter *.* silent loadview
augroup END

nnoremap <leader>z :ZenMode<cr>
lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
		{
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 90, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
}
  }
EOF

" TreeSitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp","latex","lua","python", "java"}, -- one of "all""," "maintained" (parsers with maintainers)"," or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  incremental_selection = {
      enable = true,
      },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "gr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}
EOF



let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1
