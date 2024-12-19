Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

Abz.termBufferNamePrefix = 'term://'
Abz.lazygitBufferNamePostfix = 'lazygit'
Abz.builderBufferName = "Builder"

Abz.getHistoryPath = function()
	if Terminal.getOs() == Terminal.TERMUX then
		return os.getenv("HOME") .. '/storage/shared/nvimCommandHistory/nvimCommandHistory.sh'
	end

	return os.getenv("HOME") .. '/nvimCommandHistory/nvimCommandHistory.sh'
end

Abz.getBuilderHeight = function()
	if Terminal.getOs() == Terminal.TERMUX then
		return 15
	end

	return 5
end

Abz.init = function()
end

Abz.terminalToBuilder = {}

Abz.openBuilder = function()
	local terminalBufferId = vim.api.nvim_get_current_buf()

	if string.match(vim.api.nvim_buf_get_name(terminalBufferId), Abz.lazygitBufferNamePostfix .. "$") ~= nil then
		return nil
	end

	local builderBufferId = nil
	if Table.hasKey(Abz.terminalToBuilder, terminalBufferId) then
		builderBufferId = Abz.terminalToBuilder[terminalBufferId]
	else
		builderBufferId = vim.api.nvim_create_buf(false, true)
		Abz.terminalToBuilder[terminalBufferId] = builderBufferId
		vim.api.nvim_buf_set_name(builderBufferId, vim.fn.rand() .. '-' .. Abz.builderBufferName)
	end

	vim.api.nvim_command('split')

	local windows = vim.api.nvim_list_wins()
	local builderWindowId = windows[#windows]

	vim.api.nvim_win_set_buf(builderWindowId, builderBufferId)
	vim.api.nvim_win_set_height(builderWindowId, Abz.getBuilderHeight())
	vim.opt_local.winfixheight = true
end

Abz.autocmds = {
	{
		events = { 'TermOpen' },
		settings = {
			pattern = { '*' },
			callback = Abz.openBuilder
		}
	}
}

Abz.maps = {
	{
		mode = "n",
		map = "o",
		to = function()
			local bufferName = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

			if string.match(bufferName, "^" .. Abz.termBufferNamePrefix) ~= nil then
				Keyboard.feed("<C-w>ji", 'n')
				return nil
			end

			Keyboard.feed("$a<CR>", 'n')
			return nil
		end,
		options = { noremap = false, silent = true }
	},
	{
		mode = "i",
		map = "<C-j>",
		to = function()
			local bufferName = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

			if string.match(bufferName, Abz.builderBufferName .. "$") ~= nil then
				Keyboard.feed('<ESC>0ggvG$"cy<ESC><C-w>ki<C-c><CR><C-\\><C-n>"cpi<CR><C-\\><C-n><C-w>j<C-o>i', 'n')
			end
		end,
		options = { noremap = false, silent = true }
	},
	{
		mode = "n",
		map = "<C-j>",
		to = function()
			local bufferId = vim.api.nvim_get_current_buf()
			local bufferName = vim.api.nvim_buf_get_name(bufferId)

			if Table.hasKey(Abz.terminalToBuilder,bufferId) and not Abz.bufferInAnyWindow(Abz.terminalToBuilder[bufferId]) then
				Abz.openBuilder()
				Keyboard.feed('<C-w>ji','n')
				return nil
			end

			if string.match(bufferName, Abz.builderBufferName .. "$") ~= nil then
				Keyboard.feed('0ggvG$"cy<ESC><C-w>ki<C-c><CR><C-\\><C-n>"cpi<CR><C-\\><C-n><C-w>j<C-o>', 'n')
			end
		end,
		options = { noremap = false, silent = true }
	}
}

Abz.bufferInAnyWindow = function(bufferId)
	local windows = vim.api.nvim_list_wins()

	for _, win in ipairs(windows) do
		local buf = vim.api.nvim_win_get_buf(win)

		if buf == bufferId then
			return true
		end
	end

	return false
end

return Abz
