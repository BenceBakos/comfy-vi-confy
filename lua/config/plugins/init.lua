local M = {
  -- Core plugins (always loaded)
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Load during startup
    priority = 1000, -- Load before other plugins
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  
  -- Utilities
  {
    "echasnovski/mini.nvim", -- Collection of minimal plugins
    version = false,
  },
  
  -- Plenary (dependency for many plugins)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}

-- Import individual plugin specs (they will be merged with the core plugins)
return M
