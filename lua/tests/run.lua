-- Test runner module
local Runner = {}

-- Simple test framework
local SimpleTest = require('simple_test')

-- Test basic utilities
Runner.test_utils = function()
  -- Test log module
  SimpleTest.run("log_utils", function()
    local Log = require('utils.log')
    SimpleTest.assertNotNil(Log)
    SimpleTest.assertNotNil(Log.log)
    SimpleTest.assertNotNil(Log.err)
    return true
  end)
  
  -- Test file module
  SimpleTest.run("file_utils", function()
    local File = require('utils.file')
    SimpleTest.assertNotNil(File)
    SimpleTest.assertNotNil(File.fileExists)
    SimpleTest.assertNotNil(File.readAll)
    return true
  end)
  
  -- Test terminal module
  SimpleTest.run("terminal_utils", function()
    local Terminal = require('utils.terminal')
    SimpleTest.assertNotNil(Terminal)
    SimpleTest.assertNotNil(Terminal.getOs)
    SimpleTest.assertNotNil(Terminal.binaryExists)
    
    -- Test OS constants
    SimpleTest.assertEqual(Terminal.DEBIAN, "debian")
    SimpleTest.assertEqual(Terminal.ARCH, "arch")
    SimpleTest.assertEqual(Terminal.TERMUX, "termux")
    
    -- Test OS detection
    local os = Terminal.getOs()
    SimpleTest.assertNotNil(os)
    SimpleTest.assert(os == Terminal.DEBIAN or os == Terminal.ARCH or os == Terminal.TERMUX)
    
    return true
  end)
  
  -- Test table module
  SimpleTest.run("table_utils", function()
    local Table = require('utils.table')
    SimpleTest.assertNotNil(Table)
    SimpleTest.assertNotNil(Table.hasKey)
    SimpleTest.assertNotNil(Table.hasValue)
    
    -- Test functionality
    local test_table = { a = 1, b = 2 }
    SimpleTest.assert(Table.hasKey(test_table, "a"))
    SimpleTest.assert(not Table.hasKey(test_table, "c"))
    
    return true
  end)
end

-- Test main module
Runner.test_main = function()
  SimpleTest.run("main_module", function()
    local Main = require('main')
    SimpleTest.assertNotNil(Main)
    SimpleTest.assertNotNil(Main.init)
    SimpleTest.assertNotNil(Main.sections)
    SimpleTest.assert(#Main.sections > 0)
    return true
  end)
end

-- Test base layer
Runner.test_base_layer = function()
  SimpleTest.run("base_layer", function()
    local Base = require('layers.base')
    SimpleTest.assertNotNil(Base)
    SimpleTest.assertNotNil(Base.init)
    SimpleTest.assertNotNil(Base.options)
    SimpleTest.assertNotNil(Base.options.opt)
    SimpleTest.assertNotNil(Base.maps)
    SimpleTest.assert(#Base.maps > 0)
    
    -- Test specific options
    SimpleTest.assertEqual(Base.options.opt.number, true)
    SimpleTest.assertEqual(Base.options.g.mapleader, " ")
    
    return true
  end)
end

-- Test LSP layer
Runner.test_lsp_layer = function()
  SimpleTest.run("lsp_layer", function()
    local Lsp = require('layers.lsp')
    SimpleTest.assertNotNil(Lsp)
    SimpleTest.assertNotNil(Lsp.init)
    SimpleTest.assertNotNil(Lsp.packages)
    SimpleTest.assertNotNil(Lsp.maps)
    SimpleTest.assert(#Lsp.packages > 0)
    SimpleTest.assert(#Lsp.maps > 0)
    
    -- Check key mappings
    local has_mapping = function(key)
      for _, map in ipairs(Lsp.maps) do
        if map.map == key then return true end
      end
      return false
    end
    
    SimpleTest.assert(has_mapping('gd'), "Should have gd mapping for definition")
    SimpleTest.assert(has_mapping('K'), "Should have K mapping for hover")
    
    return true
  end)
end

-- Test treesitter layer
Runner.test_treesitter_layer = function()
  SimpleTest.run("treesitter_layer", function()
    local Treesitter = require('layers.treesitter')
    SimpleTest.assertNotNil(Treesitter)
    SimpleTest.assertNotNil(Treesitter.init)
    SimpleTest.assertNotNil(Treesitter.packages)
    SimpleTest.assert(#Treesitter.packages > 0)
    return true
  end)
end

-- Run all tests
Runner.run_all = function()
  SimpleTest.init()
  
  -- Run utility tests
  Runner.test_utils()
  
  -- Run main module tests
  Runner.test_main()
  
  -- Run layer tests
  Runner.test_base_layer()
  Runner.test_lsp_layer()
  Runner.test_treesitter_layer()
  
  -- Additional layer tests can be added here
  
  -- Print summary
  local results = SimpleTest.summary()
  
  -- Return results for headless mode
  return results
end

return Runner