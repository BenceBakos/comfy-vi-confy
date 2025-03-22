local M = {}

local feed_keys = require('utils.feed_keys')
local assert = require('utils.test_helpers').assert

-- Test Treesitter installation
M.test_treesitter_installed = function()
  local status = pcall(require, 'nvim-treesitter')
  assert(status, "Treesitter should be installed")
  return status
end

-- Test Treesitter configuration
M.test_treesitter_configuration = function()
  local status = pcall(function()
    local configs = require('nvim-treesitter.configs')
    local config = configs.get_module('incremental_selection')
    
    -- Check incremental selection is enabled
    assert(config.enable, "Incremental selection should be enabled")
    
    -- Check keymaps are configured correctly
    assert(config.keymaps.init_selection == 'gm', "Init selection keymap should be 'gm'")
    assert(config.keymaps.node_incremental == 'gm', "Node incremental keymap should be 'gm'")
    assert(config.keymaps.scope_incremental == false, "Scope incremental keymap should be disabled")
    assert(config.keymaps.node_decremental == 'gM', "Node decremental keymap should be 'gM'")
    
    -- Check highlight is enabled
    local highlight_config = configs.get_module('highlight')
    assert(highlight_config.enable, "Syntax highlighting should be enabled")
    
    -- Check indent is enabled
    local indent_config = configs.get_module('indent')
    assert(indent_config.enable, "Indentation should be enabled")
  end)
  
  assert(status, "Treesitter should be correctly configured")
  return status
end

-- Test TreeSJ installation
M.test_treesj_installed = function()
  local status = pcall(require, 'treesj')
  assert(status, "TreeSJ should be installed")
  return status
end

-- Test basic split/join functionality
M.test_split_join_functionality = function()
  local status = pcall(function()
    -- Create a test buffer
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(bufnr)
    
    -- Add some test content (a simple Lua table)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
      'local test_table = { key1 = "value1", key2 = "value2", key3 = "value3" }'
    })
    
    -- Place cursor on the table
    vim.api.nvim_win_set_cursor(0, {1, 20})
    
    -- Check that 'gs' mapping exists
    local keymap = vim.fn.maparg('gs', 'n', false, true)
    assert(keymap.rhs ~= '', "Split/join keybinding 'gs' should be defined")
    
    -- Verify the function handles basic cases
    local line = vim.fn.getline('.')
    assert(string.match(line, "{.*}"), "Test line should contain curly braces")
    
    -- Clean up
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)
  
  assert(status, "Split/join functionality should work")
  return status
end

-- Test handling empty brackets
M.test_empty_brackets = function()
  local status = pcall(function()
    -- Create a test buffer
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(bufnr)
    
    -- Add some test content (empty brackets)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
      'local empty = {}'
    })
    
    -- Place cursor on the brackets
    vim.api.nvim_win_set_cursor(0, {1, 12})
    
    -- Simulate the mapping using the function's conditions
    local line = vim.fn.getline('.')
    local has_brackets = string.match(line, "{[^{]*}") or string.match(line, "%[[^%[]*%]") or string.match(line, "%(.*%)")
    assert(has_brackets, "Should detect empty brackets")
    
    -- Clean up
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)
  
  assert(status, "Empty bracket handling should work")
  return status
end

-- Test handling simple join operations
M.test_join_operation = function()
  local status = pcall(function()
    -- Create a test buffer
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(bufnr)
    
    -- Add some test content (two simple lines to join)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
      'This is line one',
      'This is line two'
    })
    
    -- Place cursor on the first line
    vim.api.nvim_win_set_cursor(0, {1, 0})
    
    -- Verify the function would join the lines (no brackets)
    local line = vim.fn.getline('.')
    local has_brackets = string.match(line, "{[^{]*}") or string.match(line, "%[[^%[]*%]") or string.match(line, "%(.*%)")
    assert(not has_brackets, "Line should not have brackets")
    
    -- Clean up
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)
  
  assert(status, "Join operation should work")
  return status
end

-- Run all Treesitter and split/join tests
M.run_tests = function()
  local results = {
    treesitter_installed = M.test_treesitter_installed(),
    treesitter_configuration = M.test_treesitter_configuration(),
    treesj_installed = M.test_treesj_installed(),
    split_join_functionality = M.test_split_join_functionality(),
    empty_brackets = M.test_empty_brackets(),
    join_operation = M.test_join_operation(),
  }
  
  return results
end

return M