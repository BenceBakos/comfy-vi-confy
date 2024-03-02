AutoCommands = {}

AutoCommands.init = function(Keyboard)
	-- persistent cursor position
	vim.api.nvim_create_autocmd(
		{ 'BufReadPost' }, {
			pattern = { '*' },
			callback = function()
				if (vim.opt_local.filetype:get():match('commit') or vim.opt_local.filetype:get():match('rebase'))
				then
					return
				end

				local markpos = vim.api.nvim_buf_get_mark(0, '"')
				if (markpos[1] > 1) and (markpos[1] <= vim.api.nvim_buf_line_count(0)) then
					vim.api.nvim_win_set_cursor(0, { markpos[1], markpos[2] })
				end
				vim.cmd('stopinsert')
			end
		})

	-- force filetypes for extensions
	vim.api.nvim_create_autocmd(
		{ 'BufReadPost' }, {
			pattern = { '*.html.twig' },
			callback = function()
				vim.bo.filetype = "html"
			end
		})

	-- Overwrite php autoindent for blade templates
	vim.api.nvim_create_autocmd(
		{ 'BufEnter' }, {
			pattern = { '*.blade.php' },
			callback = function()
				vim.opt.autoindent = true
			end
		}
	)
end

return AutoCommands
