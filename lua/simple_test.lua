-- Simple test framework for Neovim configuration
local SimpleTest = {}

-- Store test results
SimpleTest.results = {
  passed = 0,
  failed = 0,
  skipped = 0,
  tests = {}
}

-- Set up test environment
SimpleTest.init = function()
  print("Starting Neovim configuration tests...")
  return true
end

-- Define test assertion functions
SimpleTest.assert = function(value, message)
  if value then
    return true
  else
    error(message or "Assertion failed")
  end
end

SimpleTest.assertEqual = function(actual, expected, message)
  if actual == expected then
    return true
  else
    error(message or ("Expected " .. tostring(expected) .. " but got " .. tostring(actual)))
  end
end

SimpleTest.assertNil = function(value, message)
  if value == nil then
    return true
  else
    error(message or "Expected nil but got " .. tostring(value))
  end
end

SimpleTest.assertNotNil = function(value, message)
  if value ~= nil then
    return true
  else
    error(message or "Expected non-nil value")
  end
end

-- Test runner function
SimpleTest.run = function(test_name, test_func)
  SimpleTest.results.tests[test_name] = { status = "running" }
  print("Running test: " .. test_name)
  
  local status, result = pcall(test_func)
  
  if status then
    SimpleTest.results.tests[test_name] = { status = "pass" }
    SimpleTest.results.passed = SimpleTest.results.passed + 1
    print("✓ " .. test_name .. " passed")
    return true
  else
    SimpleTest.results.tests[test_name] = { status = "fail", error = result }
    SimpleTest.results.failed = SimpleTest.results.failed + 1
    print("✗ " .. test_name .. " failed: " .. result)
    return false
  end
end

-- Skip a test that can't be automatically verified
SimpleTest.skip = function(test_name, reason)
  SimpleTest.results.tests[test_name] = { status = "skipped", reason = reason }
  SimpleTest.results.skipped = SimpleTest.results.skipped + 1
  print("- " .. test_name .. " skipped: " .. reason)
end

-- Print summary of test results
SimpleTest.summary = function()
  local summary = string.format(
    "Test Summary: %d passed, %d failed, %d skipped", 
    SimpleTest.results.passed, 
    SimpleTest.results.failed, 
    SimpleTest.results.skipped
  )
  
  print(summary)
  
  if SimpleTest.results.failed > 0 then
    print("Failed tests:")
    for name, result in pairs(SimpleTest.results.tests) do
      if result.status == "fail" then
        print("  - " .. name .. ": " .. result.error)
      end
    end
  end
  
  return SimpleTest.results
end

return SimpleTest