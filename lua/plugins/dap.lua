DapConfig = {}

DapConfig.DEBUGGERBASE = "/home/b/vscode-php-debug/"
DapConfig.PHPDAPSERVERROOT = "/var/www/html/"

DapConfig.init = function(Dap)
	-- DAP PHP
	-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
	-- https://github.com/xdebug/vscode-php-debug#installation
	if File.fileExists(DapConfig.DEBUGGERBASE) then
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

return DapConfig
