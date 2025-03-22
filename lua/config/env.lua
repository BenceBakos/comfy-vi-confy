-- Environment variable loading
local M = {}

function M.load_env()
  -- Try to load from .env file in Neovim config directory
  local env_file = vim.fn.stdpath("config") .. "/.env"
  
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      -- Skip comments and empty lines
      if not line:match("^%s*#") and line:match("%S") then
        local name, value = line:match("^%s*([^=]+)%s*=%s*(.+)%s*$")
        if name and value then
          -- Remove quotes if present
          value = value:gsub("^[\"'](.+)[\"']$", "%1")
          -- Set environment variable
          vim.fn.setenv(name, value)
        end
      end
    end
    print("Loaded environment variables from " .. env_file)
  else
    print("No .env file found at " .. env_file)
  end
end

return M