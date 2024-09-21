AutoCommands = {}

AutoCommands.init = function(Keyboard)
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
