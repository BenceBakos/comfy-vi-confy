Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

Abz.executeBuilderCommand = '0ggvG$"cy<ESC><C-w>ki<C-k><C-\\><C-n>"cpi<CR><C-\\><C-n><C-w>j'

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

	local builderBufferId = Abz.getbuilderBufferForTerminal(terminalBufferId)

	vim.api.nvim_command('split')

	local windows = vim.api.nvim_list_wins()
	local builderWindowId = windows[#windows]

	vim.api.nvim_win_set_buf(builderWindowId, builderBufferId)

	vim.api.nvim_win_set_height(builderWindowId, Abz.getBuilderHeight())

	vim.opt_local.winfixheight = true
end
--
-- Abz.autocmds = {
-- 	{
-- 		events = { 'TermOpen' },
-- 		settings = {
-- 			pattern = { '*' },
-- 			callback = function()
-- 				Abz.openBuilder()
-- 			end
-- 		}
-- 	}
-- }
--
Abz.maps = {
	-- 	{
	-- 		mode = "n",
	-- 		map = "o",
	-- 		to = function()
	-- 			local bufferName = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	--
	-- 			if string.match(bufferName, "^" .. Abz.termBufferNamePrefix) ~= nil then
	-- 				Keyboard.feed("<C-w>ji", 'n')
	-- 				return nil
	-- 			end
	--
	-- 			Keyboard.feed("$a<CR>", 'n')
	-- 			return nil
	-- 		end,
	-- 		options = { noremap = false, silent = true }
	-- 	},
	-- 	{
	-- 		mode = "i",
	-- 		map = "<C-j>",
	-- 		to = function()
	-- 			local bufferName = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	--
	-- 			if string.match(bufferName, Abz.builderBufferName .. "$") ~= nil then
	-- 				Keyboard.feed('<ESC>'..Abz.executeBuilderCommand, 'n')
	-- 			end
	-- 		end,
	-- 		options = { noremap = false, silent = true }
	-- 	},
	-- 	{
	-- 		mode = "t",
	-- 		map = "<C-j>",
	-- 		to = function()
	-- 			Keyboard.feed('<C-\\><C-n><c-w>j'..Abz.executeBuilderCommand..'<c-w>ki', 'n')
	-- 		end,
	-- 		options = { noremap = false, silent = true }
	-- 	},
	-- 	{
	-- 		mode = "n",
	-- 		map = "<C-j>",
	-- 		to = function()
	-- 			local bufferId = vim.api.nvim_get_current_buf()
	-- 			local bufferName = vim.api.nvim_buf_get_name(bufferId)
	--
	-- 			-- no builder buffer, open one
	-- 			if string.match(bufferName, "^" .. Abz.termBufferNamePrefix) ~= nil and not Abz.bufferInAnyWindow(Abz.terminalToBuilder[bufferId]) then
	-- 				local terminalBufferId = vim.api.nvim_get_current_buf()
	--
	-- 				if string.match(vim.api.nvim_buf_get_name(terminalBufferId), Abz.lazygitBufferNamePostfix .. "$") ~= nil then
	-- 					return nil
	-- 				end
	--
	-- 				local builderBufferId = Abz.getbuilderBufferForTerminal(terminalBufferId)
	--
	--
	-- 				vim.cmd('split')
	-- 				vim.cmd('wincmd j')
	-- 				vim.api.nvim_set_current_buf(builderBufferId)
	--
	-- 				vim.api.nvim_win_set_height(vim.api.nvim_get_current_win(), Abz.getBuilderHeight())
	--
	-- 				vim.opt_local.winfixheight = true
	--
	--
	-- 				Keyboard.feed('<C-w>ji', 'n')
	-- 				return nil
	-- 			end
	--
	-- 			--there is a builder buffer, execute its content
	-- 			if string.match(bufferName, "^" .. Abz.termBufferNamePrefix) ~= nil and Abz.bufferInAnyWindow(Abz.terminalToBuilder[bufferId]) then
	-- 				Keyboard.feed('<c-w>j'..Abz.executeBuilderCommand..'<c-w>k', 'n')
	-- 			end
	--
	-- 			if string.match(bufferName, Abz.builderBufferName .. "$") ~= nil then
	-- 				Keyboard.feed(Abz.executeBuilderCommand, 'n')
	-- 			end
	-- 		end,
	-- 		options = { noremap = false, silent = true }
	-- 	}
}

Abz.getbuilderBufferForTerminal = function(terminalBufferId)
	if Table.hasKey(Abz.terminalToBuilder, terminalBufferId) then
		return Abz.terminalToBuilder[terminalBufferId]
	else
		local builderBufferId = vim.api.nvim_create_buf(false, true)
		Abz.terminalToBuilder[terminalBufferId] = builderBufferId
		vim.api.nvim_buf_set_name(builderBufferId, vim.fn.rand() .. '-' .. Abz.builderBufferName)

		return builderBufferId
	end
end

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
