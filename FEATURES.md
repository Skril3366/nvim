# Neovim Configuration: Features & Plugins

This document provides a comprehensive list of features configured in this
Neovim setup and the plugins responsible for them. It's intended as a reference
for understanding the configuration and for future re-engineering.

## 1. Core & Plugin Management

- **`folke/lazy.nvim`**: The plugin manager used to load all other plugins. It
  handles lazy loading, dependency management, and updating.

## 2. User Interface

### Colorschemes & Theming

- **`catppuccin/nvim`**: The currently active colorscheme (`mocha` flavor).
- **`folke/tokyonight.nvim`**: An alternative colorscheme available in the
  configuration.

### Status Line

- **`nvim-lualine/lualine.nvim`**: Provides a highly configurable and
  feature-rich status line at the bottom of the editor.

### File & Project Navigation

- **`nvim-tree/nvim-tree.lua`**: A tree-style file explorer sidebar.
- **`stevearc/oil.nvim`**: An alternative file manager that allows you to
  manipulate the filesystem in a regular Neovim buffer.

### Notifications & UI Elements

- **`rcarriga/nvim-notify`**: Replaces the default `vim.notify()` with prettier,
  more advanced notifications.
- **`j-hui/fidget.nvim`**: Displays LSP progress (e.g., "Indexing...") in a
  small, unobtrusive window.
- **`stevearc/dressing.nvim`**: Provides a better UI for built-in inputs like
  `vim.ui.select()` and `vim.ui.input()`.
- **`folke/trouble.nvim`**: A pretty, project-wide list for diagnostics,
  quickfix items, LSP references, and more.

### Visual Aids & Icons

- **`nvim-tree/nvim-web-devicons`**: Provides filetype and folder icons used by
  many other UI plugins (like `lualine`, `nvim-tree`, etc.).
- **`mbbill/undotree`**: Visualizes the undo history as a tree, allowing you to
  easily navigate and restore previous states.
- **`norcalli/nvim-colorizer.lua`**: Renders hex color codes (e.g., `#FFFFFF`)
  with their actual color as a background highlight.
- **`folke/todo-comments.nvim`**: Highlights and provides search functionality
  for keywords like `TODO`, `FIXME`, `NOTE` in your code.

## 3. Editing Enhancements

- **`numToStr/Comment.nvim`**: Provides easy-to-use keybindings for toggling
  comments on and off.
- **`kylechui/nvim-surround`**: Simplifies adding, changing, and deleting
  surrounding pairs (like quotes, brackets, and tags).
- **`echasnovski/mini.pairs`**: Automatically creates closing pairs for
  brackets, quotes, etc.
- **`echasnovski/mini.align`**: Provides functionality to align text blocks and
  selections.
- **`echasnovski/mini.trailspace`**: Highlights and automatically trims trailing
  whitespace on save.
- **`christoomey/vim-tmux-navigator`**: Allows for seamless navigation between
  Neovim splits and tmux panes using the same keybindings.

## 4. File & Project Management

- **`nvim-telescope/telescope.nvim`**: A highly extensible fuzzy finder for
  searching files, buffers, git commits, LSP definitions, and much more.
- **`nvim-telescope/telescope-fzf-native.nvim`**: A C-based sorter for Telescope
  that significantly improves performance on large projects.
- **`ThePrimeagen/harpoon`**: A file-marking utility to quickly jump between a
  list of frequently accessed files.

## 5. Coding & Language Support

### General Syntax & Highlighting

- **`nvim-treesitter/nvim-treesitter`**: The core engine for advanced,
  language-aware syntax highlighting, indentation, text objects, and more.
- **`David-Kunz/markid`**: Highlights all occurrences of the identifier under
  the cursor with a distinct color.
- **`hiphish/rainbow-delimiters.nvim`**: Colorizes matching brackets,
  parentheses, and braces to improve readability.
- **`m-demare/hlargs.nvim`**: Highlights the arguments of the function you are
  currently inside.

### LSP, Linting & Formatting

- **`neovim/nvim-lspconfig`**: Core configurations for Neovim's built-in
  Language Server Protocol (LSP) client.
- **`williamboman/mason.nvim`**: A package manager for LSPs, linters,
  formatters, and debug adapters. It simplifies their installation and management.
- **`williamboman/mason-lspconfig.nvim`**: A bridge plugin that automatically
  configures `lspconfig` for servers installed via `mason.nvim`.
- **`nvimtools/none-ls.nvim`**: Integrates external linters and formatters (like
  `prettier`, `stylua`, `black`, `shellcheck`) into Neovim's LSP workflow,
  providing diagnostics and formatting actions.
- **`onsails/lspkind.nvim`**: Adds helpful icons to LSP completion suggestions.

### Completion & Snippets

- **`hrsh7th/nvim-cmp`**: A powerful and extensible completion engine.
- **`hrsh7th/cmp-*` plugins**: A collection of sources for `nvim-cmp` that
  provide completion suggestions from the LSP, buffers, file paths, snippets, etc.
- **`L3MON4D3/LuaSnip`**: A feature-rich snippet engine.
- **`rafamadriz/friendly-snippets`**: A large, pre-configured collection of
  snippets for many languages to be used with `LuaSnip`.

### Debugging

- **`mfussenegger/nvim-dap`**: A client for the Debug Adapter Protocol (DAP),
  enabling step-through debugging inside Neovim.
- **`rcarriga/nvim-dap-ui`**: Provides a graphical UI for `nvim-dap`, showing
  scopes, watches, breakpoints, and the call stack.
- **`theHamsta/nvim-dap-virtual-text`**: Displays debug information (e.g.,
  variable values) as virtual text next to the code.
- **`jay-babu/mason-nvim-dap.nvim`**: Integrates `mason.nvim` with `nvim-dap`
  for easy installation of debug adapters.
- **`nvim-telescope/telescope-dap.nvim`**: A Telescope extension for interacting
  with the debugger.

### Language-Specific Support

- **Go**: `leoluz/nvim-dap-go` (DAP support).
- **Haskell**: `mrcjkb/haskell-tools.nvim`.
- **Java**: `nvim-java/nvim-java` (a comprehensive suite of plugins for Java
  development).
- **LaTeX**: `lervag/vimtex`.
- **Markdown**: `iamcco/markdown-preview.nvim` (live preview in browser).
- **Rust**: `simrat39/rust-tools.nvim`.
- **Scala**: `scalameta/nvim-metals`.

## 6. Git Integration

- **`lewis6991/gitsigns.nvim`**: Adds git decorations to the sign column to show
  added, modified, or deleted lines. It also provides hunk-based actions, blame
  information, and more.

## 7. AI / Code Assistance

- **`David-Kunz/gen.nvim`**: Integrates with a local Ollama instance for
  AI-powered code generation, editing, and chat.
- **`yetone/avante.nvim`**: _(Commented out)_ An alternative AI assistant
  plugin.

## 8. Utilities

- **`nvim-lua/plenary.nvim`**: A library of useful Lua functions that is a
  dependency for many other plugins (like Telescope).
- **`RaafatTurki/hex.nvim`**: A utility to view and edit files in hexadecimal
  format.
- **`vhyrro/luarocks.nvim`**: Manages Luarocks dependencies for Neovim plugins.

## 9. Inactive / Commented-Out Plugins

The following plugins are present in the configuration files but are currently
disabled (commented out):

- **`akinsho/toggleterm.nvim`**: For managing toggleable terminal windows.
- **`github/copilot.vim`**: The official GitHub Copilot plugin.
- **`ahmedkhalf/project.nvim`**: For project management and session saving.
- **`nvim-treesitter/nvim-treesitter-context`**: To show the current code
  context (e.g., function or class name) at the top of the editor.
- **`epwalsh/obsidian.nvim`**: For deep integration with the Obsidian
  note-taking app.
