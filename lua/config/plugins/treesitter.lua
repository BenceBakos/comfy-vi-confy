return {
  -- Treesitter for better syntax highlighting and code manipulation
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Basic treesitter configuration 
      -- Just enable syntax highlighting and incremental selection
      -- Keep it minimal to avoid errors
      require('nvim-treesitter.configs').setup({
        -- Minimal set of parsers that are more reliable
        ensure_installed = { 
          "lua", "vim", "vimdoc", 
        },

        -- Install parsers synchronously to ensure they work
        sync_install = true,

        -- Disable auto-install as it can be unreliable
        auto_install = false,
        
        -- Better error handling
        ignore_install_errors = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gm",
            node_incremental = "gm",
            scope_incremental = false,
            node_decremental = "gM",
          },
        },
      })
      
      -- Create a status check command to diagnose treesitter issues
      vim.api.nvim_create_user_command("TSCheck", function()
        -- Check installed parsers
        local parsers = vim.api.nvim_get_runtime_file('parser/*.so', true)
        local parser_list = {}
        for _, parser in ipairs(parsers) do
          local name = vim.fn.fnamemodify(parser, ':t:r')
          table.insert(parser_list, name)
        end
        
        vim.notify("Installed parsers: " .. table.concat(parser_list, ", "), vim.log.levels.INFO)
        
        -- Test if TreeSJ works
        local ok, treesj = pcall(require, "treesj")
        if ok then
          vim.notify("TreeSJ is installed correctly", vim.log.levels.INFO)
        else
          vim.notify("TreeSJ could not be loaded: " .. tostring(treesj), vim.log.levels.ERROR)
        end
      end, {})
    end,
  },
  
  -- TreeSJ for code block splitting and joining
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    keys = {
      -- Use pure Vim operations for splitting/joining, more reliable
      { "gs", function() 
          local line = vim.fn.getline('.')
          -- If line contains brackets, split them
          if string.match(line, "{[^{]*}") or string.match(line, "%[[^%[]*%]") or string.match(line, "%(.*%)") then
            -- Save cursor position
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            
            -- For brackets: { } or [ ] or ( )
            if vim.fn.search('[{[(]', 'bcW', line('.')) > 0 then
              -- Insert newline after bracket and before the closing bracket
              vim.cmd("normal! f{a\r")
              vim.cmd("normal! %i\r")
              vim.cmd("normal! =iB") -- Format the block
            end
            
            -- Restore cursor position (roughly)
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          else
            -- Join lines if the line doesn't contain brackets
            vim.cmd('normal! J')
          end
        end, 
        desc = "Simple split/join without Treesitter" 
      },
    },
  }
}