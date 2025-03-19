-- Main test module that collects and runs all tests

-- Basic test definitions
local M = {}

-- Test that lazy.nvim is loaded correctly
M.test_lazy_nvim = function()
  -- Check if lazy.nvim is loaded
  local status = pcall(require, 'lazy')
  assert(status, "lazy.nvim should be loaded")
  
  -- Get the count of loaded plugins
  local plugin_count = #require('lazy').plugins()
  assert(plugin_count > 1, "At least 2 plugins should be loaded")
  
  print("✅ lazy.nvim is correctly loaded with " .. plugin_count .. " plugins")
end

-- Test that we can create a buffer and write text to it
M.test_buffer = function()
  -- Create new buffer
  vim.cmd('enew')
  
  -- Write some text to it
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {"Hello, Neovim!"})
  
  -- Check that the text is in the buffer
  local line = vim.fn.getline(1)
  assert(line == "Hello, Neovim!", "Text should be written to buffer")
  
  print("✅ Buffer operations working correctly")
end

-- Run all tests
M.run_tests = function()
  print("Running Neovim configuration tests...\n")
  
  print("Testing lazy.nvim setup:")
  M.test_lazy_nvim()
  
  print("\nTesting buffer operations:")
  M.test_buffer()
  
  print("\n✅ All tests completed successfully")
end

return M
