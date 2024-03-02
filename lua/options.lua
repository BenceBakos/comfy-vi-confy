Options      = {}

Options.init = function()
	-- leader
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- disable git blame by default(enable with :GitBlameEnable)
	vim.g.gitblame_enabled = 0


	-- Options enabelsing autocomplete
	vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


	-- cmdline autocomplete setup
	vim.opt.wildmode = "longest,full"

	-- persistent undo
	vim.opt.undofile = true

	-- system clipboard
	vim.opt.clipboard = "unnamedplus"

	-- line numbers
	vim.opt.number = true

	-- errors into line number column
	vim.opt.signcolumn = "number"

	-- smart search with / and ?
	vim.opt.hlsearch = true
	vim.opt.incsearch = true
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

	-- tab size
	vim.opt.expandtab = false
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.softtabstop = -1
	vim.opt.tabpagemax = 2

	-- disable mouse
	vim.opt.mouse = nil

	-- no need to scroll till end/top of screen to move buffer content
	vim.opt.scrolloff = 8
	vim.opt.sidescrolloff = 8

	-- Spell checking
	vim.opt.spelllang = { 'en' }
	vim.opt.spell = false



	-- Auto indentation
	vim.opt.smartindent = true


	vim.opt.swapfile = false

	vim.g.tagbar_position = 'rightbelow vertical' --https://github.com/preservim/tagbar/issues/806
	vim.g.tagbar_map_showproto = 'r' -- https://github.com/preservim/tagbar/issues/795
end

return Options
