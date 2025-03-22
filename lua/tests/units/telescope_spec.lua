-- Tests for telescope functionality
local test_helpers = require('utils.test_helpers')

---@class TelescopeTests
local M = {}

---Test that telescope is correctly installed and loaded
function M.test_telescope_installed()
  -- Check if telescope module can be required
  local status = pcall(require, 'telescope')
  
  test_helpers.assert(
    status,
    'Telescope module can be loaded'
  )
end

---Test that telescope keybindings work as expected
function M.test_telescope_keybindings()
  -- In headless mode, we can't check actual keybindings
  -- So we verify that our keybinding globals are defined
  test_helpers.assert(
    vim.g.key_telescope_find_files ~= nil,
    'Telescope find_files keybinding is defined'
  )
  
  -- Verify that lazy.nvim plugin spec includes keymappings for telescope
  local plugins = require('lazy').plugins()
  local telescope_plugin
  
  for _, plugin in ipairs(plugins) do
    if plugin.name == "telescope.nvim" then
      telescope_plugin = plugin
      break
    end
  end
  
  test_helpers.assert(
    telescope_plugin ~= nil,
    'Telescope plugin is registered with lazy.nvim'
  )
end

---Test that telescope is properly configured
function M.test_telescope_configuration()
  -- Check that we can access telescope configuration
  local status, telescope_config = pcall(require, 'config.plugins.telescope')
  test_helpers.assert(
    status,
    'Telescope configuration module exists'
  )
  
  -- Check that key mapping globals are defined
  test_helpers.assert(
    vim.g.key_nav_down ~= nil,
    'Navigation down key is defined'
  )
  
  test_helpers.assert(
    vim.g.key_nav_up ~= nil,
    'Navigation up key is defined'
  )
  
  -- Check that notes path is defined
  test_helpers.assert(
    vim.g.notes_path ~= nil,
    'Notes path is defined for Telescope integration'
  )
end

return M