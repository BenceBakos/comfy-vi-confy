return {
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {},
    config = function(_, opts)
      require('hop').setup(opts)
    end,
    keys = {
      { 
        "<Leader><Leader>", 
        function()
          require('hop').hint_words({
            multi_windows = true
          })
        end,
        mode = { "n", "v" },
        desc = "Hop to word"
      },
    },
  }
}