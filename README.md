# Neovim Configuration

A modular, maintainable Neovim configuration focused on productivity and testability.

## Features

- Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- Built-in testing using [mini.test](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-test.md)
- Organized configuration structure
- Fuzzy file finding with [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- AI-assisted coding with [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)

## Getting Started

### Prerequisites

- Neovim 0.8.0+
- For CodeCompanion: An Anthropic API key for Claude access

### Installation

1. Backup your existing Neovim configuration if needed
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository
   ```sh
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

3. Set up environment variables for CodeCompanion:
   ```sh
   # Add to your .bashrc or .zshrc
   export ANTHROPIC_API_KEY="your_api_key_here"
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
│   │   └── plugins/         # Plugin configurations
│   │       ├── init.lua     # Plugin specifications
│   │       ├── telescope.lua # Telescope configuration
│   │       └── codecompanion.lua # CodeCompanion configuration
│   ├── utils/               # Utility functions
│   │   ├── feed_keys.lua    # Key simulation utilities
│   │   └── test_helpers.lua # Test helper functions
│   └── tests/               # Test files
│       ├── init.lua         # Test module with test functions
│       └── units/           # Unit tests
│           ├── telescope_spec.lua # Telescope tests
│           └── codecompanion_spec.lua # CodeCompanion tests
```

## Key Features

### Telescope

Fuzzy finding with Telescope:
- Press `<Leader>c` to find files
- Navigate with `<C-j>` and `<C-k>`

### CodeCompanion

AI-assisted coding with Claude:
- Press `<space>aa` to open the CodeCompanion prompt
- Current buffer is automatically used as context
- File changes are applied automatically when requested
- Brief explanations are provided for changes

#### TDD Workflow

CodeCompanion includes a TDD workflow to help with test-driven development:
1. Provide specifications for what you want to build
2. CodeCompanion writes tests based on the specifications
3. It confirms the tests are good before implementation
4. It implements the features to make tests pass
5. It can refactor and iterate as needed

To use the TDD workflow:
```
:CodeCompanion workflow tdd
```

## Running Tests

From within Neovim, you can run all tests with:

```lua
:lua require('tests').run_tests()
```

Or run specific tests:

```lua
-- Core tests
:lua require('tests').test_lazy_nvim()
:lua require('tests').test_buffer()

-- Plugin tests
:lua require('tests').test_codecompanion()
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

### Phase 2: Telescope Integration (2025-03-21)

- Added Telescope for fuzzy file finding with `<Leader>c` keybinding
- Integrated notes directory with Telescope search
- Configured custom navigation with `<C-j>` and `<C-k>` keybindings
- Improved architecture with separate utility modules:
  - Added `utils/feed_keys.lua` for simulating user keypresses
  - Added `utils/test_helpers.lua` for standardized test assertions
- Enhanced testing framework with plugin-specific unit tests
- Added configuration constants for keys and paths

### Phase 3: CodeCompanion Integration (2025-03-22)

- Added CodeCompanion.nvim for AI-assisted coding with Claude
- Configured with the following features:
  - `<space>aa` keybinding to open the prompt
  - Automatic buffer context integration
  - Automatic file modifications without confirmation
  - Concise explanations after changes
- Added custom TDD workflow for test-driven development
- Implemented comprehensive tests for the CodeCompanion feature:
  - Installation verification
  - Keybinding tests
  - Configuration validation
  - TDD workflow verification
- Updated documentation with usage instructions
