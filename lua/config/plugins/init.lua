return {
  -- List your basic plugins here
  -- They'll be loaded by lazy.nvim
  
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Make sure we load this during startup
    priority = 1000, -- Make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  
  -- Add mini.nvim collection for mini.test
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  -- Test configuration
  {
    "echasnovski/mini.test",
    dependencies = { "echasnovski/mini.nvim" },
    config = function()
      require("mini.test").setup()
    end,
  },
  
  -- Add your other plugins here
  -- Example:
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function()
  --     require("config.plugins.treesitter")
  --   end,
  -- },
}
