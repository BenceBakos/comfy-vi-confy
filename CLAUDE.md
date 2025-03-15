# Neovim Configuration Guidelines

## Build/Test Commands
- Install packages: `nvim -c "lua Package.install({'owner/repo'})"` 
- Check for binary: `lua Terminal.binaryExists('executable')`
- Run OS check: `lua print(Terminal.getOs())`
- Log information: `lua Log.log("message")`

## Code Style Guidelines
- Use `snake_case` for variable and function names
- Use `PascalCase` for module/class names
- Use 2-space indentation (consistent with existing code)
- Prefer `require()` at the top of files
- Use `Table.hasKey()` for safe key existence checks
- Use `File.fileExists()` for file existence checks
- Wrap OS-specific code in OS detection conditionals
- Return early with `if not x then return false end` pattern
- Module format: single table with properties and functions
- Error handling: use `Log.log()` or `Log.err()` for errors
- Globals should be in `UPPER_CASE`

## Layer Structure
Each layer module should follow the established pattern with sections:
- `packages`: list of plugins to install
- `excludeOs`: OS names to exclude
- `init`: initialization function
- `options`: vim options with g/opt/wo sub-tables
- `maps`: keyboard mappings
