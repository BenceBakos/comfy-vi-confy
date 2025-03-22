-- Main test module that collects and runs all tests
local test_helpers = require('utils.test_helpers')

---@class TestSuite
local M = {}

-- Import unit tests
local telescope_tests = require('tests.units.telescope_spec')

-- Test that lazy.nvim is loaded correctly
---@return nil
function M.test_lazy_nvim()
  -- Check if lazy.nvim is loaded
  local status = pcall(require, 'lazy')
  test_helpers.assert(status, "lazy.nvim is loaded")
  
  -- Get the count of loaded plugins
  local plugin_count = #require('lazy').plugins()
  test_helpers.assert(plugin_count > 1, "At least 2 plugins are loaded")
end

-- Test that we can create a buffer and manipulate it
---@return nil
function M.test_buffer()
  -- Create new buffer
  vim.cmd('enew')
  
  -- Directly set line content instead of simulating keypresses
  vim.api.nvim_buf_set_lines(0, 0, 1, false, {"Hello, Neovim!"})
  
  -- Check that the text is in the buffer
  local line = vim.fn.getline(1)
  test_helpers.assert(line == "Hello, Neovim!", "Buffer manipulation works correctly")
end

-- Run core functionality tests
---@return nil
function M.run_core_tests()
  print("\n=== Running Core Tests ===")
  
  test_helpers.run_test("lazy.nvim setup", M.test_lazy_nvim)
  test_helpers.run_test("buffer operations", M.test_buffer)
end

-- Run plugin-specific tests
---@return nil
function M.run_plugin_tests()
  print("\n=== Running Plugin Tests ===")
  
  -- Telescope tests
  test_helpers.run_test("telescope installation", telescope_tests.test_telescope_installed)
  test_helpers.run_test("telescope keybindings", telescope_tests.test_telescope_keybindings)
  test_helpers.run_test("telescope configuration", telescope_tests.test_telescope_configuration)
end

-- Run all tests
---@return nil
function M.run_tests()
  print("Running Neovim configuration tests...")
  
  M.run_core_tests()
  M.run_plugin_tests()
  
  print("\n✅ All tests completed successfully")
end

return M
