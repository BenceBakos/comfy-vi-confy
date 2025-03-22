return {
  -- Common utilities and dependencies for other plugins
  
  -- Dressing.nvim improves the default Neovim UI components
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          -- Configuration for vim.ui.input
          enabled = true,
          default_prompt = "Input: ",
          prompt_align = "left",
          insert_only = true,
          border = "rounded",
          relative = "editor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        select = {
          -- Configuration for vim.ui.select
          enabled = true,
          backend = { "telescope", "builtin" },
          trim_prompt = true,
          telescope = nil,
          builtin = {
            border = "rounded",
            relative = "editor",
            win_options = {
              winblend = 0,
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
        },
      })
    end,
  },
  
  -- Plenary provides commonly needed Lua functions (already included in init.lua)
  -- Add any other utility plugins below
}