Options      = {}

Options.init = function()

	-- disable git blame by default(enable with :GitBlameEnable)
	vim.g.gitblame_enabled = 0

	vim.g.tagbar_position = 'rightbelow vertical' --https://github.com/preservim/tagbar/issues/806
	vim.g.tagbar_map_showproto = 'r'        -- https://github.com/preservim/tagbar/issues/795

	-- Options enabelsing autocomplete
	vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


	-- cmdline autocomplete setup
	vim.opt.wildmode = "longest,full"

	

	

	

	

	
	--




	-- Spell checking
	vim.opt.spelllang = { 'en' }
	vim.opt.spell = false






end

return Options
