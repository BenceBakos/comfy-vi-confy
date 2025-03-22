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
  
  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required dependency
    },
    config = function()
      local telescope_config = require("config.plugins.telescope")
      telescope_config.setup()
    end,
    keys = {
      {
        vim.g.key_telescope_find_files,
        function() require("telescope.builtin").find_files() end,
        desc = "Find files in project and notes",
      },
    },
  },
  
  -- CodeCompanion for AI-assisted coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Optional: for better UI
    },
    config = function()
      local codecompanion_config = require("config.plugins.codecompanion")
      codecompanion_config.setup()
    end,
    keys = {
      {
        vim.g.key_codecompanion_prompt,
        function() require("codecompanion.actions").toggle() end,
        desc = "Toggle CodeCompanion prompt",
      },
    },
  },
}
