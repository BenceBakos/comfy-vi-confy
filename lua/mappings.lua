Mappings = {}

Mappings.init = function(Hop, Keyboard,Log)
	Keyboard.mapFunction({ "n", "v" }, "<Leader><Leader>", function()
		Hop.hint_words({
			multi_windows = true
		})
	end)


	-- LSP bindings
	Keyboard.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', false)
	Keyboard.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', false)
	Keyboard.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', false)
	Keyboard.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', false)
	Keyboard.map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', false)
	Keyboard.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', false)
	Keyboard.map('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<cr>', false)
	Keyboard.map('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', false)
	Keyboard.map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', false)
	Keyboard.map('n', 'gof', '<cmd>lua vim.diagnostic.open_float()<cr>', false)
	Keyboard.map('n', 'gm', '<cmd>lua vim.diagnostic.goto_prev()<cr>', false)
	Keyboard.map('n', 'gM', '<cmd>lua vim.diagnostic.goto_next()<cr>', false)
	Keyboard.map('n', 'gwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', false)
	Keyboard.map('n', 'gwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', false)
	Keyboard.mapFunction("n", "gF", function()
		vim.lsp.buf.format { async = true }
	end)


	-- Dap mappings
	Keyboard.map('n', '<Leader>m', ':lua require"dap".toggle_breakpoint()<CR>', false)
	Keyboard.map('n', '<Leader>n', ':lua require"dap".continue()<CR>', false)
	Keyboard.map('n', '<Leader>i', ':lua require"dap".step_into()<CR>', false)
	Keyboard.map('n', '<Leader>o', ':lua require"dap".step_over)<CR>', false)
	Keyboard.map('n', '<Leader>s', ':lua require("dap").repl.open({}, "vsplit")<CR>', false)
	Keyboard.map('n', '<Leader>p', ':lua require("dap").repl.open({}, "vsplit")<CR><C-w>hi.scopes<CR><Esc>{', false)


	-- fuzzy search file finder
	Keyboard.map('n', '<Leader>c', ':lua require("nvim-find.defaults").files()<cr>')


	-- tabs/buffers
	Keyboard.map('n', 'th', ':tabfirst<CR>', false)
	Keyboard.map('n', 'tj', ':tabnext<CR>', false)
	Keyboard.map('n', 'tk', ':tabprev<CR>', false)
	Keyboard.map('n', 'tl', ':tablast<CR>', false)
	Keyboard.map('n', 'té', ':vsplit<Space>', { noremap = true, silent = false })
	Keyboard.map('n', 'tt', ':tabedit<Space>', { noremap = true, silent = false })
	Keyboard.map('n', 'td', ':tabclose<CR>', false)
	Keyboard.map("n", "ti", ":tabedit<Space><CR>:tab ter<CR>", false)
	Keyboard.map("n", "to", ":botright vnew<Space><CR>:tab ter<CR>", false)

	Keyboard.mapFunction("n", "tu", function()
		vim.api.nvim_feedkeys(":tabedit " .. vim.fn.getcwd() .. '/', "n", true)
	end)

	Keyboard.mapFunction("n", "tá", function()
		vim.api.nvim_feedkeys(":vsplit " .. vim.fn.getcwd() .. '/', "n", true)
	end)

	-- qwertz modes
	Keyboard.map("n", "é", "$")
	Keyboard.map("v", "é", "$")

	-- remove selection
	Keyboard.map("n", 'á', ':noh<CR>')

	-- close line with semicolon
	Keyboard.map('n', ';', '$a;<ESC>')

	-- stay in visual mode while indenting
	Keyboard.map("v", "<", "<gv")
	Keyboard.map("v", ">", ">gv")

	-- exit to normal mode from terminal
	Keyboard.map("t", "<Esc>", "<C-\\><C-n>")

	-- close symbols
	Keyboard.map("i", "(", "()<Esc>i")
	Keyboard.map("i", "[", "[]<Esc>i")
	Keyboard.map("i", "{", "{}<Esc>i")
	Keyboard.map("i", "'", "''<Esc>i")
	Keyboard.map("i", '"', '""<Esc>i')
	Keyboard.map("i", '`', '``<Esc>i')


	-- remove double symbols in insert mode
	--on a beautifull sunday afternoon...
	vim.cmd [[
	inoremap <expr> <bs> Remove_pair()
	imap <c-h> <bs>

	function Remove_pair() abort
	  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
	  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
	endfunction
]]


	-- quit from current window
	Keyboard.map("n", "ó", ":q<CR>")

	-- remove highlights
	Keyboard.map("n", "ö", ":noh<CR>")

	-- Better window navigation
	Keyboard.map("n", "<Leader>h", "<C-w>h")
	Keyboard.map("n", "<Leader>j", "<C-w>j")
	Keyboard.map("n", "<Leader>k", "<C-w>k")
	Keyboard.map("n", "<Leader>l", "<C-w>l")
	Keyboard.map("n", "<Leader>é", "<C-w>l")

	Keyboard.map("n", "ch", "<C-w>h")
	Keyboard.map("n", "cj", "<C-w>j")
	Keyboard.map("n", "ck", "<C-w>k")
	Keyboard.map("n", "cl", "<C-w>l")
	Keyboard.map("n", "cé", "<C-w>l")

	-- go to netrw from file
	Keyboard.map("n", "-", ":Explore<CR>")

	-- next/prev finding
	Keyboard.map("n", "ú", ":cn<CR>")
	Keyboard.map("n", "Ú", ":cp<CR>")

	--tagbar
	Keyboard.map("n", "ű", ":TagbarToggle fcj<CR>")
	Keyboard.map('n', '<C-j>', ':TagbarJumpNext<CR>')
	Keyboard.map('n', '<C-k>', ':TagbarJumpPrev<CR>')


end

return Mappings
