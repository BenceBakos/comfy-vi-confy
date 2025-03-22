-- Tests for the main module
local mini_test = require('mini.test')

local T = mini_test.new_set()

-- Test main module structure
T['main_structure'] = function()
  -- Require the main module
  local main = require('main')
  
  -- Check that it exists and has the expected structure
  mini_test.expect.global(main).exists()
  mini_test.expect.global(main.init).is.function_()
  mini_test.expect.global(main.sections).is.table()
  mini_test.expect.global(main.initSection).is.function_()
  
  -- Check that we have sections
  mini_test.expect.global(#main.sections).is_not.equal(0)
end

-- Test layer initialization
T['layer_initialization'] = function()
  -- Require the main module
  local main = require('main')
  
  -- Mock a simple test layer
  local test_layer = {
    options = {
      opt = {
        test_option = true
      }
    },
    maps = {
      { mode = 'n', map = 'test', to = 'test_command' }
    }
  }
  
  -- Test optionsPath initialization
  for _, section in ipairs(main.sections) do
    if type(section.path) == 'table' and section.path[1] == 'options' and section.path[2] == 'opt' then
      local opt_init_fn = section.init
      -- Should be able to call the init function without errors
      mini_test.expect.no_error(function()
        for k, v in pairs(test_layer.options.opt) do
          opt_init_fn(k, v)
        end
      end)
    end
  end
  
  -- Test that initSection doesn't error on our test layer
  mini_test.expect.no_error(function()
    main.initSection(test_layer, 'options', function() end)
  end)
end

return T