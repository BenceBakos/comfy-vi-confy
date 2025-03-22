-- Tests for utility modules
local mini_test = require('mini.test')

local T = mini_test.new_set()

-- Test utility modules
T['utils_log'] = function()
  -- Require log module
  local log = require('utils.log')
  
  -- Check that it exists and has the expected functions
  mini_test.expect.global(log).exists()
  mini_test.expect.global(log.log).is.function_()
  mini_test.expect.global(log.err).is.function_()
  mini_test.expect.global(log.serializeValue).is.function_()
end

T['utils_file'] = function()
  -- Require file module
  local file = require('utils.file')
  
  -- Check that it exists and has the expected functions
  mini_test.expect.global(file).exists()
  mini_test.expect.global(file.fileExists).is.function_()
  mini_test.expect.global(file.readAll).is.function_()
end

T['utils_terminal'] = function()
  -- Require terminal module
  local terminal = require('utils.terminal')
  
  -- Check that it exists and has the expected functions and constants
  mini_test.expect.global(terminal).exists()
  mini_test.expect.global(terminal.getOs).is.function_()
  mini_test.expect.global(terminal.binaryExists).is.function_()
  mini_test.expect.global(terminal.run).is.function_()
  
  -- Check OS constants
  mini_test.expect.global(terminal.DEBIAN).is.string()
  mini_test.expect.global(terminal.ARCH).is.string()
  mini_test.expect.global(terminal.TERMUX).is.string()
  
  -- Check that OS detection returns a valid value
  local os = terminal.getOs()
  mini_test.expect.global(os).is.string()
  mini_test.expect(os == terminal.DEBIAN or os == terminal.ARCH or os == terminal.TERMUX).is.truthy()
end

T['utils_table'] = function()
  -- Require table module
  local table_util = require('utils.table')
  
  -- Check that it exists and has the expected functions
  mini_test.expect.global(table_util).exists()
  mini_test.expect.global(table_util.hasKey).is.function_()
  mini_test.expect.global(table_util.hasValue).is.function_()
  
  -- Test basic functionality
  local test_table = { a = 1, b = 2 }
  mini_test.expect(table_util.hasKey(test_table, 'a')).is.truthy()
  mini_test.expect(table_util.hasKey(test_table, 'c')).is.falsy()
end

return T