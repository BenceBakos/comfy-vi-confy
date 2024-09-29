Terminal = require("utils.terminal")

Base = {}

Base.init = function()
	-- remove double symbols in insert mode
	-- TODO to lua since nvim in my life...
	vim.cmd [[
	inoremap <expr> <bs> Remove_pair()
	imap <c-h> <bs>

	function Remove_pair() abort
	  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
	  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
	endfunction
]]

	-- print('hello')
end

Base.options = {
	g = {
		mapleader = " ",
		maplocalleader = " ",
	},
	opt = {
		-- persistent undo
		undofile = true,
		-- system clipboard
		clipboard = "unnamedplus",
		-- line numbers
		number = true,
		-- errors into line number column
		signcolumn = "number",
		-- smart search with / and ?
		hlsearch = true,
		incsearch = true,
		ignorecase = true,
		smartcase = true,
		wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx',
		-- tab size
		expandtab = false,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = -1,
		tabpagemax = 2,
		-- disable mouse
		mouse = nil,
		-- no need to scroll till end/top of screen to move buffer content
		scrolloff = 8,
		sidescrolloff = 8,
		-- Auto indentation
		smartindent = true,
		-- no swap file
		swapfile = false,
		-- cmdline autocomplete setup
		wildmode = "longest,full",
		-- autocomplete enable
		completeopt = { 'menu', 'menuone', 'noselect' }
	}
}

Base.commands = {
	-- copy path to clipboard
	Cgpath = ":let @+=expand('%:p')",
	Cpath = ":let @+=expand('%')",
	-- quickhand refinment
	E = 'e',
	W = 'w',
	Wq = 'wq',
	WQ = 'wq',
	Edit = 'edit',

}

Base.autocmds = {
	-- persistent cursor position
	{
		events = { 'BufReadPost' },
		settings = {
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
		}
	}
}

Base.maps = {
	-- {mode='', map='', to='',options={}},

	--tabs/buffers
	{ mode = 'n', map = 'th',        to = ':tabfirst<CR>',                                       options = false },
	{ mode = 'n', map = 'tj',        to = ':tabnext<CR>',                                        options = false },
	{ mode = 'n', map = 'tk',        to = ':tabprev<CR>',                                        options = false },
	{ mode = 'n', map = 'tl',        to = ':tablast<CR>',                                        options = false },
	{ mode = 'n', map = 'té',        to = ':vsplit<Space>',                                      options = { noremap = true, silent = false } },
	{ mode = 'n', map = 'tt',        to = ':tabedit<Space>',                                     options = { noremap = true, silent = false } },
	{ mode = 'n', map = 'td',        to = ':tabclose<CR>',                                       options = false },
	{ mode = "n", map = "ti",        to = ":tabedit<Space><CR>:tab ter<CR>",                     options = false },
	{ mode = "n", map = "to",        to = ":botright vnew<Space><CR>:tab ter<CR>",               options = false },
	-- qwertz modes
	{ mode = "n", map = "é",         to = "$" },
	{ mode = "v", map = "é",         to = "$" },
	-- remove selection
	{ mode = "n", map = 'á',         to = ':noh<CR>' },
	-- close line with semicolon
	{ mode = 'n', map = ';',         to = '$a;<ESC>' },
	-- stay in visual mode while indenting
	{ mode = "v", map = "<",         to = "<gv" },
	{ mode = "v", map = ">",         to = ">gv" },
	-- exit to normal mode from terminal
	{ mode = "t", map = "<Esc>",     to = "<C-\\><C-n>" },
	-- close symbols
	{ mode = "i", map = "(",         to = "()<Esc>i" },
	{ mode = "i", map = "[",         to = "[]<Esc>i" },
	{ mode = "i", map = "{",         to = "{}<Esc>i" },
	{ mode = "i", map = "'",         to = "''<Esc>i" },
	{ mode = "i", map = '"',         to = '""<Esc>i' },
	{ mode = "i", map = '`',         to = '``<Esc>i' },
	-- quit from current window
	{ mode = "n", map = "ó",         to = ":q<CR>" },

	-- remove highlights
	{ mode = "n", map = "ö",         to = ":noh<CR>" },

	-- Better window navigation
	{ mode = "n", map = "<Leader>h", to = "<C-w>h" },
	{ mode = "n", map = "<Leader>j", to = "<C-w>j" },
	{ mode = "n", map = "<Leader>k", to = "<C-w>k" },
	{ mode = "n", map = "<Leader>l", to = "<C-w>l" },
	{ mode = "n", map = "<Leader>é", to = "<C-w>l" },

	-- go to netrw from file
	{ mode = "n", map = "-",         to = ":Explore<CR>" },

	-- next/prev quickfix item
	{ mode = "n", map = "ú",         to = ":cn<CR>" },
	{ mode = "n", map = "Ú",         to = ":cp<CR>" },
	{ mode = "n", map = "co",        to = ":copen<CR>" },

	-- get to do items
	{ mode = "n", map = "gT",        to = ':cexpr system("git grep -iF --line-number TODO")<CR>' },

	-- registry accessing qwertz mod
	{ mode = "n", map = '"',         to = "ö" },
	{
		mode = 'n',
		map = 'tu',
		to = function()
			vim.api.nvim_feedkeys(":tabedit " .. vim.fn.getcwd() .. '/', "n", true)
		end,
		options = false
	},
	{
		mode = 'n',
		map = 'tá',
		to = function()
			vim.api.nvim_feedkeys(":vsplit " .. vim.fn.getcwd() .. '/', "n", true)
		end,
		options = false
	},
}

return Base
