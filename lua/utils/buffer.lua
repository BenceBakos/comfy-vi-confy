Buffer = {}

Buffer.getHeight = function()
    return vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) - 1 -- minus one for statusline
end

Buffer.getWidth = function()
    return vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())
end

Buffer.setContent = function (bufferId,startLine,endLine,lines)
	vim.api.nvim_buf_set_lines(bufferId, startLine, endLine, false, lines)
end

Buffer.getContent = function (bufferId)
    return vim.api.nvim_buf_get_lines(bufferId, 0, vim.api.nvim_buf_line_count(bufferId), false)
end

return Buffer
