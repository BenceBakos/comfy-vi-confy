# CLAUDE.md - Neovim Configuration Helper

This file serves as a memory aid for Claude to better assist with this Neovim configuration.

## Commands

### Testing

```lua
-- Run all tests
require('tests').run_tests()

-- Run specific test
require('tests').test_lazy_nvim()
require('tests').test_buffer()
```

## Configuration Structure

- `init.lua`: Main entry point that bootstraps lazy.nvim and loads configuration
- `lua/config/options.lua`: Neovim options and settings
- `lua/config/keymaps.lua`: Keyboard mappings
- `lua/config/plugins/`: Plugin configurations
  - `init.lua`: Main plugin specification file
- `lua/tests/`: Test files using mini.test
  - `init.lua`: Main test runner
  - `lazy_spec.lua`: Tests for lazy.nvim functionality
  - `buffer_spec.lua`: Tests for buffer operations

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

### Future Phases (Planned)

- Phase 2: Add LSP support and completion
- Phase 3: Add file navigation and search tools 
- Phase 4: Add Git integration
- Phase 5: Add debugging support