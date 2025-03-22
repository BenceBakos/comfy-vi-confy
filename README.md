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

## Getting Started

### Prerequisites

- Neovim 0.8.0+
- Git (for plugin management)

### Installation

1. Backup your existing Neovim configuration if needed
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository
   ```sh
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

3. (Optional) Create a `.env` file for environment variables:
   ```sh
   echo "NOTES_PATH=$HOME/notes" > ~/.config/nvim/.env
   ```

4. Start Neovim
   ```sh
   nvim
   ```
   The configuration will automatically bootstrap lazy.nvim and install all plugins.

## Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/              # Configuration modules
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── env.lua          # Environment variable loading
│   │   └── plugins/         # Plugin configurations
│   │       ├── init.lua     # Core plugin specs
│   │       ├── telescope.lua # Telescope plugin specs
│   │       ├── treesitter.lua # Treesitter plugin specs
│   │       └── utils.lua    # Utility plugin specs
│   ├── utils/               # Utility functions
│   │   ├── feed_keys.lua    # Key simulation utilities
│   │   └── test_helpers.lua # Test helper functions
│   └── tests/               # Test files
│       ├── init.lua         # Test module with test functions
│       └── units/           # Unit tests
│           ├── telescope_spec.lua # Telescope tests
│           └── treesitter_spec.lua # Treesitter tests
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
```

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
