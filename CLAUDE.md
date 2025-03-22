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
require('tests').test_treesitter()

-- Run plugin-specific tests
local telescope_tests = require('tests.units.telescope_spec')
telescope_tests.test_telescope_installed()
telescope_tests.test_telescope_keybindings()
telescope_tests.test_telescope_configuration()

local treesitter_tests = require('tests.units.treesitter_spec')
treesitter_tests.test_treesitter_installed()
treesitter_tests.test_treesitter_configuration()
treesitter_tests.test_treesj_installed()
treesitter_tests.test_treesj_keybinding()
```

## Configuration Structure

- `init.lua`: Main entry point that bootstraps lazy.nvim and loads configuration
- `lua/config/`: Core configuration modules
  - `options.lua`: Neovim options and settings with option-related constants
  - `keymaps.lua`: Keyboard mappings with key mapping constants
  - `env.lua`: Environment variable loading and management
  - `plugins/`: Plugin configurations
    - `init.lua`: Core plugin specification file
    - `telescope.lua`: Telescope configuration and specs
    - `treesitter.lua`: Treesitter configuration and specs
    - `utils.lua`: Utility plugins and shared dependencies
- `lua/utils/`: Utility functions with single responsibility
  - `feed_keys.lua`: Utilities for simulating user keypresses
  - `test_helpers.lua`: Helper functions for testing
- `lua/tests/`: Test files  
  - `init.lua`: Main test runner
  - `units/`: Unit tests for each feature
    - `telescope_spec.lua`: Tests for telescope functionality
    - `treesitter_spec.lua`: Tests for Treesitter and TreeSJ functionality

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

## Treesitter and Split/Join Usage

Treesitter provides advanced syntax highlighting and code manipulation capabilities.

```lua
-- Treesitter commands
:TSInstall <language>           -- Install a specific language parser
:TSUpdate                       -- Update all installed parsers
:TSInstallInfo                  -- Show installation status of parsers
:TSCheck                        -- Diagnose treesitter installation issues

-- Incremental selection
gm                              -- Expand selection to next node
gM                              -- Shrink selection to previous node

-- Split/Join commands
gs                              -- Toggle code block between split/join
                               -- Works on any content with braces {}, brackets [], or parentheses ()
                               -- For lines without these characters, performs line join (J)
```

## Development Process

The development process follows these principles:

1. **Test-Driven Development**:
   - Write tests before implementing features
   - Ensure tests clearly define expected behavior
   - Implement minimal code to make tests pass
   - Refactor while maintaining passing tests

2. **Modular Design**:
   - Each plugin has its own configuration file
   - Each feature is isolated with well-defined responsibilities 
   - Core functionality is separate from plugin-specific code
   - Utilities are reusable across different parts of the configuration

3. **Progressive Enhancement**:
   - Basic functionality works without dependencies
   - Features fail gracefully when dependencies are missing
   - Clear error messages help diagnose issues
   - Diagnostic commands help troubleshoot problems

## Release History

### v1.0: Basic Setup (2025-03-19)

- Implemented modular configuration with lazy.nvim for plugin management
- Created basic configuration structure with separate modules for options, keymaps, and plugins
- Added testing functionality with simple test suite for verifying:
  - Proper lazy.nvim setup and plugin loading
  - Basic buffer operations
- Set up Tokyo Night theme as the default colorscheme
- Configured sensible defaults and basic key mappings
- Organized a clean, maintainable codebase structure for future expansion

### v1.1: Telescope Integration (2025-03-21)

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

### v1.2: Treesitter and Split/Join Integration (2025-03-22)

- Added Treesitter for enhanced syntax highlighting and code manipulation:
  - Focused on essential parsers for better reliability
  - Incremental selection with `gm` and `gM` keymaps
  - Added robust error handling and diagnostics
- Implemented split/join functionality with native Vim operations:
  - `gs` keybinding for universal bracket splitting and joining
  - Works independently of Treesitter parsers for maximum reliability
  - Pure Vim implementation guarantees compatibility with all file types
- Added comprehensive tests for these features:
  - Verification of proper installation and fallback behavior
  - Multiple test cases covering different content types
  - Regression tests for error conditions
- Added diagnostic command `:TSCheck` to troubleshoot installation issues

### v2.0: Refactored Architecture (2025-03-22)

- Complete refactoring of the codebase for improved extensibility
- Each plugin now has its own dedicated configuration file
- Simplified architecture with better separation of concerns
- Improved plugin isolation for easier debugging and maintenance
- Enhanced modularity to make adding new features easier
- Added utils.lua for shared utility plugins and dependencies
- Streamlined importing system using lazy.nvim's import feature

### Future Development (Planned)

- LSP support and completion
- Additional file navigation and search tools
- Git integration
- Debugging support