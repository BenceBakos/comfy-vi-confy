-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load config modules
require("config.options")
require("config.keymaps")

-- Define plugins inline to ensure full control
local plugins = {
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
      -- Access telescope config directly
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
}

-- Initialize lazy.nvim
require("lazy").setup(plugins, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})