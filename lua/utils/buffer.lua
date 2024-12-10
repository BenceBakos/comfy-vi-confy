Buffer = {}

-- Get height
-- Get wifth
-- Get contents
-- Set content
-- Maybe vim api supports exactly what I need

Buffer.getHeight = function(buffer)
    return vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) - 1 -- minus one for statusline
end

Buffer.getWidth = function()
    return vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())
end



return Buffer
