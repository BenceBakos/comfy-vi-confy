-- Tests for the base layer
local mini_test = require('mini.test')

local T = mini_test.new_set()

-- Test base layer structure
T['base_layer'] = function()
  -- Require the base layer
  local base = require('layers.base')
  
  -- Check that it exists and has the expected structure
  mini_test.expect.global(base).exists()
  mini_test.expect.global(base.init).is.function_()
  mini_test.expect.global(base.options).is.table()
  mini_test.expect.global(base.options.opt).is.table()
  mini_test.expect.global(base.maps).is.table()
  
  -- Check that we have at least one mapping
  mini_test.expect.global(#base.maps).is_not.equal(0)
  
  -- Check that we have required options
  mini_test.expect.global(base.options.opt.number).is.boolean()
  mini_test.expect.global(base.options.g.mapleader).is.string()
end

return T