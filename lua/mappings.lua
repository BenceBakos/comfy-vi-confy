Mappings = {}

Mappings.init = function(Hop, Keyboard,Log)

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
