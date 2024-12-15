Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

Abz.separator = "#--------"

Abz.historyPrefix = "History-"
Abz.builderPrefix = "Builder-"

-- fields:
-- - historyBufferId
-- - builderBufferId
-- - instaneId
Abz.instances = {}

Abz.getHistoryPath = function()
	if Terminal.getOs() == Terminal.TERMUX then
		return os.getenv("HOME") .. '/storage/shared/nvimCommandHistory/nvimCommandHistory.sh'
	end

	return os.getenv("HOME") .. '/nvimCommandHistory/nvimCommandHistory.sh'
end

Abz.init = function()
end

Abz.maps = {
	{
		mode = 'n',
		map = '<Leader>m',
		to = function()
			local instanceId = vim.fn.rand()

			local historyBufferId = vim.api.nvim_create_buf(true, true)

			vim.api.nvim_buf_set_name(historyBufferId, Abz.historyPrefix .. instanceId)
			vim.api.nvim_set_current_buf(historyBufferId)

			-- read store into buffer
			local history = File.readAll(Abz.getHistoryPath())

			if not history then
				Log.err('Failed to load history for Abz from path: ' .. Abz.getHistoryPath())
				return nil
			end

			vim.api.nvim_buf_set_lines(historyBufferId, 0, -1, false, vim.split(history, '\n'))

			table.insert(Abz.instances, {
				historyBufferId = historyBufferId,
				instanceId = instanceId
			})
		end,
		options = false
	},
	{
		mode = 'n',
		map = 'c',
		to = function()
			local bufferId = vim.api.nvim_get_current_buf()

			local activeInstance = nil
			for _, instance in pairs(Abz.instances) do
				if instance.historyBufferId == bufferId then
					activeInstance = instance
					break
				end
			end

			if activeInstance == nil then return nil end

			if vim.fn.has_key(activeInstance,'builderBufferId') == 0 then
				activeInstance.builderBufferId = vim.api.nvim_create_buf(true,true)

				vim.cmd('split')

				local windows = vim.api.nvim_list_wins()
				local activeWindow = windows[#windows]

				vim.api.nvim_win_set_buf(activeWindow,activeInstance.builderBufferId)
			end

			local content = vim.fn.getreg('+')
			Log.log(content)
			Log.log(content == Abz.separator)
			-- get yanked, line, or section

			-- paste yanked into split

		end,
		options = { noremap = true, silent = true }
	}
}

return Abz
