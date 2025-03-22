return {
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 0

      -- Helper function to check if a binary exists
      local function binary_exists(binary_name)
        local handle = io.popen("command -v " .. binary_name)
        if handle then
          local result = handle:read("*a")
          handle:close()
          return #result > 0
        end
        return false
      end

      -- Set up keymaps
      vim.keymap.set('n', 'tg', function()
        if binary_exists('lazygit') then
          vim.api.nvim_feedkeys(":tab terminal lazygit<CR>", "n", true)
        else
          vim.api.nvim_feedkeys(":tab terminal<CR>", "n", true)
        end
      end, { desc = "Open lazygit in tab" })

      vim.keymap.set('n', 'gé', function()
        if binary_exists('lazygit') then
          vim.api.nvim_feedkeys(":vsplit<CR><C-w>l:terminal lazygit<CR>", "n", true)
        else
          vim.api.nvim_feedkeys(":vsplit<CR><C-w>l :terminal<CR>", "n", true)
        end
      end, { desc = "Open lazygit in vsplit" })
    end,
  }
}