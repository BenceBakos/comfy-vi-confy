Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

-- fields:
-- - historyBufferId
-- - builderBufferId
-- - instaneId
Abz.instances = {}

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

Base.autocmds = {
	{
		events = { 'TermOpen' },
		settings = {
			pattern = { '*' },
			callback = function(ev)

				Log.log(ev)
				if string.match(ev.match,  Abz.lazygitBufferNamePostfix .. "$") ~= nil  then
					return nil
				end

				local builderBufferId = vim.api.nvim_create_buf(false, true)

				vim.cmd('split')

				local windows = vim.api.nvim_list_wins()

				local builderWindowId = windows[#windows]

				vim.api.nvim_win_set_buf(builderWindowId, builderBufferId)
				vim.api.nvim_buf_set_name(builderBufferId,Abz.builderBufferName)
				vim.api.nvim_win_set_height(builderWindowId, Abz.getBuilderHeight())
			end
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

			Keyboard.feed("j0i<CR><ESC>ki", 'n')
			return nil
		end,
		options = { noremap = false, silent = true }
	},
	{
		mode = "i",
		map = "<C-j>",
		to = function()
			local bufferName = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
			if bufferName == Abz.builderBufferName then
				-- todo: get buffer content, copy to terminal, execute, and get back into builder
			end

		end,
		options = { noremap = false, silent = true }
	},
}

return Abz
