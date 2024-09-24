Mappings = {}

Mappings.init = function(Hop, Keyboard,Log)

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


	--tagbar
	Keyboard.map("n", "ű", ":TagbarToggle fcj<CR>")
	-- Keyboard.map('n', '<C-j>', ':TagbarJumpNext<CR>')
	-- Keyboard.map('n', '<C-k>', ':TagbarJumpPrev<CR>')


end

return Mappings
