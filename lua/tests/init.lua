-- Main test module that collects and runs all tests
local test_helpers = require('utils.test_helpers')

---@class TestSuite
local M = {}

-- Import unit tests
local telescope_tests = require('tests.units.telescope_spec')
local treesitter_tests = require('tests.units.treesitter_spec')
local feature_tests = require('tests.units.feature_tests')

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
  
  -- Treesitter tests
  test_helpers.run_test("treesitter installation", treesitter_tests.test_treesitter_installed)
  test_helpers.run_test("treesitter configuration", treesitter_tests.test_treesitter_configuration)
  test_helpers.run_test("treesj installation", treesitter_tests.test_treesj_installed)
  test_helpers.run_test("split/join functionality", treesitter_tests.test_split_join_functionality)
  test_helpers.run_test("empty brackets handling", treesitter_tests.test_empty_brackets)
  test_helpers.run_test("join operation", treesitter_tests.test_join_operation)
  
  -- Added feature tests
  print("\n=== Running Feature Tests ===")
  test_helpers.run_test("command aliases", feature_tests.test_command_aliases)
  test_helpers.run_test("keymaps", feature_tests.test_keymaps)
  test_helpers.run_test("auto pair function", feature_tests.test_auto_pair_function)
  test_helpers.run_test("oil plugin", feature_tests.test_oil_plugin)
  test_helpers.run_test("comment plugin", feature_tests.test_comment_plugin)
  test_helpers.run_test("hop plugin", feature_tests.test_hop_plugin)
  test_helpers.run_test("lsp config", feature_tests.test_lsp_config)
end

-- Run all tests
---@return nil
function M.run_tests()
  print("Running Neovim configuration tests...")
  
  M.run_core_tests()
  M.run_plugin_tests()
  
  print("\n✅ All tests completed successfully")
end

-- Run Treesitter tests only
---@return nil
function M.test_treesitter()
  print("\n=== Running Treesitter and Split/Join Tests ===")
  
  test_helpers.run_test("treesitter installation", treesitter_tests.test_treesitter_installed)
  test_helpers.run_test("treesitter configuration", treesitter_tests.test_treesitter_configuration)
  test_helpers.run_test("treesj installation", treesitter_tests.test_treesj_installed)
  test_helpers.run_test("split/join functionality", treesitter_tests.test_split_join_functionality)
  test_helpers.run_test("empty brackets handling", treesitter_tests.test_empty_brackets)
  test_helpers.run_test("join operation", treesitter_tests.test_join_operation)
end

-- Run Feature tests only
---@return nil
function M.test_features()
  print("\n=== Running Feature Tests ===")
  
  test_helpers.run_test("command aliases", feature_tests.test_command_aliases)
  test_helpers.run_test("keymaps", feature_tests.test_keymaps)
  test_helpers.run_test("auto pair function", feature_tests.test_auto_pair_function)
  test_helpers.run_test("oil plugin", feature_tests.test_oil_plugin)
  test_helpers.run_test("comment plugin", feature_tests.test_comment_plugin)
  test_helpers.run_test("hop plugin", feature_tests.test_hop_plugin)
  test_helpers.run_test("lsp config", feature_tests.test_lsp_config)
end

return M
