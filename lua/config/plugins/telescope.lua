-- Telescope configuration

---@class TelescopeConfig
local M = {}

---Setup Telescope with custom configuration
---@return nil
function M.setup()
  local telescope = require('telescope')
  
  -- Configure telescope
  telescope.setup {
    defaults = {
      -- Default configuration for telescope
      prompt_prefix = '> ',
      selection_caret = '> ',
      entry_prefix = '  ',
      
      -- Custom mappings
      mappings = {
        i = {
          -- Custom navigation in insert mode
          [vim.g.key_nav_down] = require('telescope.actions').move_selection_next,
          [vim.g.key_nav_up] = require('telescope.actions').move_selection_previous,
        },
        n = {
          -- Custom navigation in normal mode
          [vim.g.key_nav_down] = require('telescope.actions').move_selection_next,
          [vim.g.key_nav_up] = require('telescope.actions').move_selection_previous,
        },
      },
    },
    pickers = {
      find_files = {
        -- Include the notes directory in find_files search
        find_command = function()
          local command = { 'find' }
          
          -- Add project directory
          table.insert(command, '.')
          
          -- Add notes directory if it exists and is different from current dir
          local notes_path = vim.g.notes_path
          if notes_path and vim.fn.isdirectory(notes_path) == 1 and 
             vim.fn.fnamemodify(notes_path, ':p') ~= vim.fn.getcwd() .. '/' then
            table.insert(command, notes_path)
          end
          
          -- Add remaining find arguments
          table.insert(command, '-type')
          table.insert(command, 'f')
          table.insert(command, '-not')
          table.insert(command, '-path')
          table.insert(command, '*/node_modules/*')
          table.insert(command, '-not')
          table.insert(command, '-path')
          table.insert(command, '*/.git/*')
          
          return command
        end,
      },
    },
  }
  
  -- Load telescope extensions if needed
  -- telescope.load_extension('other_extension')
end

return M