return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
      },
      sort = {
        { "mtime", "desc" },
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<BS>", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "t-", "<cmd>vsplit<cr><cmd>Oil<cr>", desc = "Open parent directory in vsplit" },
    },
  },
}