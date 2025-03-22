-- Testing utilities to standardize and simplify test creation

---@class TestHelperOptions
---@field cleanup function|nil Function to run after the test to clean up

---@class TestHelpers
local M = {}

-- Try to load mini.test if available but don't error if not
local has_mini_test, mini_test = pcall(require, "mini.test")
if has_mini_test then
  -- Use mini.test's setup but don't export it directly
  mini_test.setup()
end

-- Get the feed_keys utility
local feed_keys = require('utils.feed_keys')

---Assert that a condition is true and print result
---@param condition boolean The condition to check
---@param message string Description of the test
---@param error_msg string|nil Optional error message if condition fails
function M.assert(condition, message, error_msg)
  if condition then
    print("✅ " .. message)
    return true
  else
    local err = error_msg or "Test failed: " .. message
    print("❌ " .. err)
    error(err)
  end
end

---Run a test with proper setup and teardown
---@param name string Name of the test
---@param test_fn function The test function to run
---@param opts TestHelperOptions|nil Optional settings for the test
function M.run_test(name, test_fn, opts)
  opts = opts or {}
  
  print("\nRunning test: " .. name)
  
  -- Setup clean environment
  vim.cmd('enew')
  
  -- Run the test
  local success, result = pcall(test_fn)
  
  -- Run cleanup if provided
  if opts.cleanup then
    pcall(opts.cleanup)
  end
  
  -- Close test buffer
  vim.cmd('bdelete!')
  
  -- Report results
  if success then
    print("✅ Test completed: " .. name)
  else
    print("❌ Test failed: " .. name)
    print("Error: " .. tostring(result))
    error(result)
  end
  
  return success
end

---Check if a plugin is installed and loaded
---@param plugin_name string Name of the plugin
---@return boolean is_loaded Whether the plugin is loaded
function M.plugin_loaded(plugin_name)
  local plugins = require('lazy').plugins()
  for _, plugin in ipairs(plugins) do
    if plugin.name == plugin_name and plugin._.loaded then
      return true
    end
  end
  return false
end

-- Expose feed_keys functions
M.feed_keys = feed_keys.feed_keys
M.feed_key_sequence = feed_keys.feed_key_sequence

return M