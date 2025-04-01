Terminal = require("utils.terminal")
Lsp = require("layers.ide")

Php = {}

Php.excludeOs = {
	Terminal.TERMUX
}

Php.packages = {
	'gbprod/phpactor.nvim',
	'nvim-lua/plenary.nvim',
	'neovim/nvim-lspconfig'
}

Php.dependencyBinaries = {
	debian = { 'php', 'composer', 'phpactor' },
	arch = { 'php', 'composer', 'phpactor' }
}

Php.phpactor = nil

Php.init = function()
	-- LspConfig.intelephense.setup({
	-- 	capabilities = capabilities,
	-- 	init_options = {
	-- 		licenceKey = File.get_intelephense_license()
	-- 	},
	-- })

	Php.phpactor = Package.want("phpactor")

	if not Php.phpactor then return false end


	Php.phpactor.setup({
		install = {
			path = vim.fn.stdpath("data") .. "/opt/",
			branch = "master",
			bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
		},
		lspconfig = {
			enable = true,
			options = {
				-- init_options = {
				-- 	["language_server_phpstan.enabled"] = true,
				-- 	["language_server_psalm.enabled"] = true,
				-- 	["language_server_php_cs_fixer.enabled"] = true,
				-- 	["php_code_sniffer.enabled"] = true,
				-- 	["prophecy.enabled"] = true,
				-- }
			}
		}
	})

	local handler = Package.want('phpactor.handler.update')

	if not handler then return false end

	handler()


end

Php.maps = {
	{
		mode = {'n','v'},
		map = "gj",
		to = function()
			Php.phpactor.rpc('context_menu', {})
		end
	}
}

return Php
