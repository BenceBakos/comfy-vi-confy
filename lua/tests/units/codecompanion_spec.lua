-- Tests for CodeCompanion functionality
local test_helpers = require('utils.test_helpers')

---@class CodeCompanionTests
local M = {}

---Test that CodeCompanion is correctly installed and loaded
function M.test_codecompanion_installed()
  -- Check if codecompanion module can be required
  local status = pcall(require, 'codecompanion')
  
  test_helpers.assert(
    status,
    'CodeCompanion module can be loaded'
  )
end

---Test that CodeCompanion keybindings work as expected
function M.test_codecompanion_keybindings()
  -- Verify that our keybinding globals are defined
  test_helpers.assert(
    vim.g.key_codecompanion_prompt ~= nil,
    'CodeCompanion prompt keybinding is defined'
  )
  
  -- Verify that lazy.nvim plugin spec includes keymappings for codecompanion
  local plugins = require('lazy').plugins()
  local codecompanion_plugin
  
  for _, plugin in ipairs(plugins) do
    if plugin.name == "codecompanion.nvim" then
      codecompanion_plugin = plugin
      break
    end
  end
  
  test_helpers.assert(
    codecompanion_plugin ~= nil,
    'CodeCompanion plugin is registered with lazy.nvim'
  )
  
  -- Check that the keys are properly configured
  test_helpers.assert(
    codecompanion_plugin.keys ~= nil,
    'CodeCompanion has keybindings configured'
  )
end

---Test that CodeCompanion is properly configured
function M.test_codecompanion_configuration()
  -- Check that we can access codecompanion configuration
  local status, codecompanion_config = pcall(require, 'config.plugins.codecompanion')
  test_helpers.assert(
    status,
    'CodeCompanion configuration module exists'
  )
  
  -- Verify that the config module has a setup function
  test_helpers.assert(
    type(codecompanion_config.setup) == 'function',
    'CodeCompanion configuration has setup function'
  )
  
  -- Test that the configuration contains our custom settings
  local codecompanion = require('codecompanion')
  local config = codecompanion.config
  
  -- Check auto_execute setting is enabled
  test_helpers.assert(
    config.actions.auto_execute == true,
    'CodeCompanion has auto_execute enabled'
  )
  
  -- Check short_explanations setting is enabled
  test_helpers.assert(
    config.actions.short_explanations == true,
    'CodeCompanion has short_explanations enabled'
  )
  
  -- Check buffer context strategy
  test_helpers.assert(
    config.context.strategy == 'buffer',
    'CodeCompanion uses buffer context strategy'
  )
end

---Test that TDD workflow is properly configured
function M.test_codecompanion_tdd_workflow()
  local codecompanion = require('codecompanion')
  local workflows = codecompanion.config.workflows
  
  -- Check TDD workflow exists
  test_helpers.assert(
    workflows ~= nil and workflows.tdd ~= nil,
    'CodeCompanion has TDD workflow configured'
  )
  
  -- Check TDD workflow has a name
  test_helpers.assert(
    workflows.tdd.name == 'TDD Workflow',
    'TDD workflow has the correct name'
  )
  
  -- Check TDD workflow has a prompt
  test_helpers.assert(
    type(workflows.tdd.prompt) == 'string' and 
    #workflows.tdd.prompt > 0,
    'TDD workflow has a prompt configured'
  )
end

return M