Terminal = require("utils.terminal")
Package = require("utils.package")
File = require("utils.file")

Dap = {}

Dap.excludeOs = {
	Terminal.TERMUX
}

Dap.DEBUGGERBASE = "~/vscode-php-debug/"
Dap.PHPDAPSERVERROOT = "/var/www/html/"

Dap.packages = {
	'mfussenegger/nvim-dap'
	-- TODO depending on other package(Mason install in this case)
}

Dap.init = function()
	-- DAP PHP
	-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
	-- https://github.com/xdebug/vscode-php-debug#installation
	if File.fileExists(Dap.DEBUGGERBASE) then
		Dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { DapConfig.DEBUGGERBASE .. "out/" .. 'phpDebug.js' }
		}

		Dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				log = true,
				serverSourceRoot = vim.fn.expand("%:p:h") .. "/",
				localSourceRoot = vim.fn.expand("%:p:h") .. "/"
			}
		}

		--force deleting of debugger buffer
		vim.api.nvim_create_autocmd('BufHidden', {
			pattern  = '[dap-terminal]*',
			callback = function(arg)
				vim.schedule(function() vim.api.nvim_buf_delete(arg.buf, { force = true }) end)
			end
		})
	end
end

Dap.maps = {
	{ mode = 'n', map = '<Leader>m', to = ':lua require"dap".toggle_breakpoint()<CR>',                                   false },
	{ mode = 'n', map = '<Leader>n', to = ':lua require"dap".continue()<CR>',                                            options = false },
	{ mode = 'n', map = '<Leader>i', to = ':lua require"dap".step_into()<CR>',                                           options = false },
	{ mode = 'n', map = '<Leader>o', to = ':lua require"dap".step_over)<CR>',                                            options = false },
	{ mode = 'n', map = '<Leader>s', to = ':lua require("dap").repl.open({},options= "vsplit")<CR>',                     false },
	{ mode = 'n', map = '<Leader>p', to = ':lua require("dap").repl.open({},options= "vsplit")<CR><C-w>hi.scopes<CR><Esc>{', false },
}


return Dap
