-- Test layer for Neovim configuration
Terminal = require("utils.terminal")

Test = {}

Test.init = function()
  -- Create command to run all tests
  vim.api.nvim_create_user_command('Test', function()
    -- Run all tests
    require('tests.run').run_all()
  end, {})
end

return Test