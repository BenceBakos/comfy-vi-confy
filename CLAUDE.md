# CLAUDE.md - Neovim Configuration Helper

This file serves as a memory aid for Claude to better assist with this Neovim configuration.

## Commands

### Testing

```lua
-- Run all tests
require('tests').run_tests()

-- Run specific test groups
require('tests').run_core_tests()
require('tests').run_plugin_tests()

-- Run specific tests
require('tests').test_lazy_nvim()
require('tests').test_buffer()

-- Run plugin-specific tests
local telescope_tests = require('tests.units.telescope_spec')
telescope_tests.test_telescope_installed()
telescope_tests.test_telescope_keybindings()
telescope_tests.test_telescope_configuration()
```

## Configuration Structure

- `init.lua`: Main entry point that bootstraps lazy.nvim and loads configuration
- `lua/config/`: Core configuration modules
  - `options.lua`: Neovim options and settings with option-related constants
  - `keymaps.lua`: Keyboard mappings with key mapping constants
  - `plugins/`: Plugin configurations
    - `init.lua`: Main plugin specification file
    - `telescope.lua`: Telescope configuration
- `lua/utils/`: Utility functions with single responsibility
  - `feed_keys.lua`: Utilities for simulating user keypresses
  - `test_helpers.lua`: Helper functions for testing
- `lua/tests/`: Test files  
  - `init.lua`: Main test runner
  - `units/`: Unit tests for each feature
    - `telescope_spec.lua`: Tests for telescope functionality

## Code Style Preferences

- Indentation: 2 spaces
- String quotes: Single quotes for Lua strings, double quotes for plugin specs
- Line length: Prefer lines under 100 characters
- Comments: Use -- for single-line comments, --[[ ]] for multi-line comments

## Plugin Management

```lua
-- Check plugin status
:lua = require('lazy').stats()

-- Open lazy.nvim UI
:Lazy

-- Install plugins
:Lazy install

-- Update plugins
:Lazy update
```

## Phases

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

- Added improved architecture with `/lua/utils` for reusable functions
- Added configuration globals in appropriate modules for constants
- Implemented Telescope for fuzzy file finding:
  - Fuzzy finding with `<Leader>c` 
  - Navigation with `<C-j>` and `<C-k>`
  - Integration with notes directory from `notes_path` global
- Improved testing framework:
  - Key simulation with `utils.feed_keys`
  - Unit tests for each feature
  - Structured tests with proper assertions
  - Test helpers for consistent testing

### Future Phases (Planned)

- Phase 3: Add LSP support and completion
- Phase 4: Add additional file navigation and search tools 
- Phase 5: Add Git integration
- Phase 6: Add debugging support