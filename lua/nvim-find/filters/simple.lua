-- A simple string matching filter

local async = require("nvim-find.async")

local simple = {}

function simple.run(source)
  return function(finder)
    for results in async.iterate(source, finder) do
      if type(results) == "table" then
        coroutine.yield(vim.tbl_filter(
          function(value)
            return string.find(value, finder.query, 0, true)
          end,
          results
        ))
      else
        coroutine.yield(results)
      end
    end
  end
end

return simple