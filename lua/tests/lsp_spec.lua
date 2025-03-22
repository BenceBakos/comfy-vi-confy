-- Tests for the lsp layer
local mini_test = require('mini.test')

local T = mini_test.new_set()

-- Test lsp layer structure
T['lsp_layer'] = function()
  -- Require the lsp layer
  local lsp = require('layers.lsp')
  
  -- Check that it exists and has the expected structure
  mini_test.expect.global(lsp).exists()
  mini_test.expect.global(lsp.init).is.function_()
  mini_test.expect.global(lsp.packages).is.table()
  mini_test.expect.global(lsp.maps).is.table()
  
  -- Check that we have packages
  mini_test.expect.global(#lsp.packages).is_not.equal(0)
  
  -- Check that we have mappings
  mini_test.expect.global(#lsp.maps).is_not.equal(0)
  
  -- Verify common LSP mappings exist
  local has_mapping = function(key)
    for _, map in ipairs(lsp.maps) do
      if map.map == key then
        return true
      end
    end
    return false
  end
  
  mini_test.expect(has_mapping('gd')).is.truthy('Should have gd mapping for definition')
  mini_test.expect(has_mapping('K')).is.truthy('Should have K mapping for hover')
end

return T