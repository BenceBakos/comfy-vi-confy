-- Test runner script for Neovim configuration
-- Run with: nvim --headless -c "luafile test_run.lua"

-- Load globals and utilities
require('globals')

-- Run all tests
local results = require('tests.run').run_all()

-- Exit with appropriate status code
if results.failed > 0 then
  os.exit(1)
else
  os.exit(0)
end