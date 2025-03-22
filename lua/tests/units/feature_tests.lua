-- Tests for the various features added
local test_helpers = require('utils.test_helpers')

---@class FeatureTests
local M = {}

-- Test command aliases
function M.test_command_aliases()
  -- Check if commands are defined
  local commands = vim.api.nvim_get_commands({})
  
  test_helpers.assert(
    commands.Cgpath ~= nil,
    'Cgpath command is defined'
  )
  
  test_helpers.assert(
    commands.Cpath ~= nil,
    'Cpath command is defined'
  )
  
  test_helpers.assert(
    commands.E ~= nil,
    'E command is defined'
  )
  
  test_helpers.assert(
    commands.W ~= nil,
    'W command is defined'
  )
  
  test_helpers.assert(
    commands.Wq ~= nil,
    'Wq command is defined'
  )
  
  test_helpers.assert(
    commands.WQ ~= nil,
    'WQ command is defined'
  )
  
  test_helpers.assert(
    commands.Edit ~= nil,
    'Edit command is defined'
  )
end

-- Test keymaps
function M.test_keymaps()
  -- Check if tab keymaps are defined
  local th_keymap = vim.fn.maparg('th', 'n', false, true)
  test_helpers.assert(
    th_keymap.rhs ~= nil and th_keymap.rhs ~= "",
    'th keymap is defined'
  )
  
  -- Check a keymap with a special character
  local special_keymap = vim.fn.maparg('é', 'n', false, true)
  test_helpers.assert(
    special_keymap.rhs ~= nil and special_keymap.rhs ~= "",
    'é keymap is defined'
  )
  
  -- Check bracket mapping
  local bracket_keymap = vim.fn.maparg('{', 'i', false, true)
  test_helpers.assert(
    bracket_keymap.rhs ~= nil and bracket_keymap.rhs ~= "",
    '{ keymap is defined'
  )
  
  -- Check window navigation
  local window_nav = vim.fn.maparg('<Leader>h', 'n', false, true)
  test_helpers.assert(
    window_nav.rhs ~= nil and window_nav.rhs ~= "",
    '<Leader>h keymap is defined'
  )
end

-- Test auto-pair function
function M.test_auto_pair_function()
  -- Verify the RemovePairs function exists
  local exists = vim.fn.exists('*RemovePairs')
  test_helpers.assert(
    exists == 1,
    'RemovePairs function exists'
  )
  
  -- Check if backspace is mapped to the function
  local bs_mapping = vim.fn.maparg('<bs>', 'i', false, true)
  test_helpers.assert(
    bs_mapping.expr == 1,
    'Backspace has expression mapping'
  )
  
  -- Test auto-closing functionality
  vim.cmd('enew')
  -- Insert a pair
  vim.api.nvim_feedkeys('i(', 'tx', true)
  local line = vim.fn.getline('.')
  test_helpers.assert(
    line == '()',
    'Auto-closing pair works correctly'
  )
end

-- Test oil.nvim
function M.test_oil_plugin()
  -- Verify that Oil is loaded
  local status = pcall(require, 'oil')
  test_helpers.assert(
    status,
    'Oil.nvim is loaded'
  )
  
  -- Check if keymaps are defined
  local oil_keymap = vim.fn.maparg('-', 'n', false, true)
  test_helpers.assert(
    oil_keymap.rhs ~= nil and oil_keymap.rhs:match('Oil'),
    'Oil - keymap is defined'
  )
end

-- Test Comment.nvim
function M.test_comment_plugin()
  -- Verify that Comment is loaded
  local status = pcall(require, 'Comment')
  test_helpers.assert(
    status,
    'Comment.nvim is loaded'
  )
end

-- Test Hop.nvim
function M.test_hop_plugin()
  -- Verify that Hop is loaded
  local status = pcall(require, 'hop')
  test_helpers.assert(
    status,
    'Hop.nvim is loaded'
  )
  
  -- Check if leader-leader keymap is defined
  local hop_keymap = vim.fn.maparg('<Leader><Leader>', 'n', false, true)
  test_helpers.assert(
    hop_keymap.callback ~= nil,
    'Hop <Leader><Leader> keymap is defined'
  )
end

-- Test LSP configuration
function M.test_lsp_config()
  -- Verify that lspconfig is loaded
  local status = pcall(require, 'lspconfig')
  test_helpers.assert(
    status,
    'nvim-lspconfig is loaded'
  )
  
  -- Test Mason
  local mason_status = pcall(require, 'mason')
  test_helpers.assert(
    mason_status,
    'Mason is loaded'
  )
  
  -- Test cmp
  local cmp_status = pcall(require, 'cmp')
  test_helpers.assert(
    cmp_status,
    'nvim-cmp is loaded'
  )
end

return M