# Neovim Configuration

A modular, maintainable Neovim configuration focused on productivity and testability.

## Features

- Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- Built-in testing using [mini.test](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-test.md)
- Organized configuration structure

## Getting Started

### Prerequisites

- Neovim 0.8.0+

### Installation

1. Backup your existing Neovim configuration if needed
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository
   ```sh
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

3. Start Neovim
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
│   │   └── plugins/         # Plugin configurations
│   │       └── init.lua     # Plugin specifications
│   └── tests/               # Test files
│       └── init.lua         # Test module with test functions
```

## Running Tests

From within Neovim, you can run all tests with:

```lua
:lua require('tests').run_tests()
```

Or run a specific test:

```lua
:lua require('tests').test_lazy_nvim()
:lua require('tests').test_buffer()
```

## Release Notes

### Phase 1: Basic Setup (2025-03-19)

- Implemented modular configuration with lazy.nvim for plugin management
- Created basic configuration structure with separate modules for options, keymaps, and plugins
- Added testing functionality with simple test suite for verifying:
  - Proper lazy.nvim setup and plugin loading
  - Basic buffer operations
- Set up Tokyo Night theme as the default colorscheme
- Configured sensible defaults and basic key mappings
- Organized a clean, maintainable codebase structure for future expansion
