# Neovim Configuration

A modular, extensible Neovim configuration focused on simplicity and maintainability.

## Features

- **Modular Architecture**: Each plugin has its own configuration file
- **Test-Driven Development**: Comprehensive test suite for all features
- **Simple and Extensible**: Easy to add new plugins and features
- **Tokyo Night Theme**: Beautiful, modern color scheme
- **Fuzzy Finding**: Telescope integration with project and notes search
- **Enhanced Syntax**: Treesitter integration for better code highlighting
- **Split/Join**: Universal bracket splitting and joining with `gs`
- **File Navigation**: Oil.nvim integration for buffer-based file navigation
- **Smart Comments**: Comment.nvim for intelligent code commenting
- **Quick Navigation**: Hop.nvim for EasyMotion-like cursor movement
- **Git Integration**: Git blame information and lazygit support
- **LSP Support**: Language server protocol for many languages with fallback options
- **PHP Development**: Support for both Phpactor and Intelephense with auto fallback
- **Code Completion**: Advanced completion engine with nvim-cmp
- **Auto LSP Installation**: Mason.nvim for automated LSP and tool management
- **Code Formatting**: Null-LS for automatic formatting with php-cs-fixer and phpstan

## Getting Started

### Prerequisites

- Neovim 0.8.0+
- Git (for plugin management)
- Node.js (for certain LSP servers)
- Python 3 (for certain formatters)
- A Nerd Font (for icons, recommended but optional)

### Installation

1. Backup your existing Neovim configuration if needed
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository
   ```sh
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

3. (Optional) Set up your notes directory in your shell environment:
   ```sh
   export NOTES_PATH="$HOME/notes"
   ```

4. (Optional) If you use a QWERTZ keyboard layout and want to remap Caps Lock:
   ```sh
   setxkbmap -option caps:escape
   ```

5. Start Neovim
   ```sh
   nvim
   ```
   The configuration will automatically bootstrap lazy.nvim and install all plugins.

6. Wait for all LSP servers to be installed on first launch
   LSP servers, formatters, and linters will be automatically installed by Mason.
   This may take a few minutes on first launch.

## Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/              # Configuration modules
│   │   ├── options.lua      # Neovim options and settings
│   │   ├── keymaps.lua      # Key mappings
│   │   └── plugins/         # Plugin configurations
│   │       ├── init.lua     # Core plugin specs
│   │       ├── telescope.lua # Telescope plugin specs
│   │       ├── treesitter.lua # Treesitter plugin specs
│   │       ├── lsp.lua      # LSP configuration
│   │       ├── oil.lua      # Oil.nvim configuration
│   │       ├── comment.lua  # Comment.nvim configuration
│   │       ├── hop.lua      # Hop.nvim configuration
│   │       ├── git-blame.lua # Git blame configuration
│   │       └── utils.lua    # Utility plugin specs
│   ├── utils/               # Utility functions
│   │   ├── feed_keys.lua    # Key simulation utilities
│   │   └── test_helpers.lua # Test helper functions
│   └── tests/               # Test files
│       ├── init.lua         # Test module with test functions
│       └── units/           # Unit tests
│           ├── telescope_spec.lua # Telescope tests
│           ├── treesitter_spec.lua # Treesitter tests
│           └── feature_tests.lua # Tests for added features
```

## Key Features

### Telescope

Fuzzy finding with Telescope:
- Press `<Leader>c` to find files
- Navigate with `<C-j>` and `<C-k>`
- Integrates with notes directory (set via `NOTES_PATH`)

### Treesitter

Enhanced syntax highlighting and code manipulation:
- Focused on essential parsers for better reliability
- Incremental selection with `gm` and `gM` keymaps
- Diagnostic command `:TSCheck` for troubleshooting

### Split/Join

Universal code block formatting:
- Press `gs` to toggle between split and join formats
- Works on any content with braces `{}`, brackets `[]`, or parentheses `()`
- For lines without these characters, performs line join (like Vim's `J`)

### File Navigation with Oil.nvim

- Press `-` or `<BS>` to open parent directory in buffer
- Navigate with normal Vim movements
- Displays hidden files by default
- Sorts files by modification time (newest first)

### Improved Code Commenting

Comment.nvim provides smart commenting for any language:
- Uses treesitter for accurate comment detection
- Toggle comments with `gcc` (current line) and `gc` (motion/selection)
- Handles multi-line comments appropriately

### Fast Navigation with Hop

- Press `<Leader><Leader>` to activate Hop word mode
- Type a few characters to jump to any word in visible buffers
- Works in normal and visual modes

### LSP Integration

Full Language Server Protocol support:
- Automatically installs language servers with Mason
- Provides intelligent code completion
- Offers code navigation, diagnostics, and refactoring
- Supports formatting and linting with null-ls

## Running Tests

From within Neovim, you can run all tests with:

```lua
:lua require('tests').run_tests()
```

Or run specific tests:

```lua
-- Core tests
:lua require('tests').run_core_tests()

-- Plugin tests
:lua require('tests').run_plugin_tests()

-- Specific feature tests
:lua require('tests').test_treesitter()
:lua require('tests').test_features()
```

## Dependencies

This configuration relies on the following plugins:

### Core
- [lazy.nvim](https://github.com/folke/lazy.nvim): Plugin manager
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim): Theme
- [mini.nvim](https://github.com/echasnovski/mini.nvim): Collection of small independent plugins
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): Lua utility functions

### File Navigation and UI
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder
- [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim): File explorer in buffer
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Icons for UI elements

### Editor Enhancements
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim): Smart commenting
- [smoka7/hop.nvim](https://github.com/smoka7/hop.nvim): EasyMotion-like navigation
- [f-person/git-blame.nvim](https://github.com/f-person/git-blame.nvim): Git blame information

### Syntax and Parsing
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Advanced syntax highlighting
- [Wansmer/treesj](https://github.com/Wansmer/treesj): Split/join code blocks

### LSP and Completion
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): LSP configuration
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim): Package manager
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): Mason integration with LSP
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim): Formatting and linting
- [jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim): Mason integration with null-ls
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Completion engine
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): LSP source for nvim-cmp
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer): Buffer words source for nvim-cmp
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path): Path source for nvim-cmp
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): Snippets source for nvim-cmp
- [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim): LSP progress display

## Extending

To add a new plugin:

1. Create a new file in `lua/config/plugins/` (e.g., `lsp.lua`)
2. Return a table with the plugin specification following this pattern:

```lua
return {
  {
    "plugin-author/plugin-name",
    dependencies = {
      -- Any dependencies
    },
    config = function()
      -- Configuration code
    end,
    keys = {
      -- Any keybindings
    },
  }
}
```

The plugin will be automatically loaded thanks to lazy.nvim's import feature.

## Release History

### v1.0: Basic Setup (2025-03-19)

- Initial modular configuration with lazy.nvim
- Basic configuration structure and Tokyo Night theme
- Simple test suite for core functionality

### v1.1: Telescope Integration (2025-03-21)

- Added Telescope for fuzzy file finding
- Improved architecture with utility functions
- Enhanced testing framework

### v1.2: Treesitter and Split/Join (2025-03-22)

- Added Treesitter for better syntax highlighting
- Implemented split/join functionality with `gs`
- Added comprehensive tests for these features

### v2.0: Refactored Architecture (2025-03-22)

- Simplified and streamlined codebase
- Each plugin now has its own dedicated configuration file
- Improved modularity and extensibility
- Better separation of concerns for easier maintenance
