Terminal = require("utils.terminal")

Php = {}

Php.excludeOs = {
	Terminal.TERMUX
}

Php.dependencyBinaries = {
	debian = { 'php', 'composer' },
	arch = { 'php', 'composer' }
}

Php.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	local capabilities = LspConfig.util.default_config.capabilities

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}

	LspConfig.intelephense.setup({
		capabilities = capabilities,
		init_options = {
			licenceKey = File.get_intelephense_license()
		},
		root_dir = function()
			return vim.loop.cwd()
		end,
		settings = {
			intelephense = {
				telemetry = {
					enabled = true,
				},
				completion = {
					fullyQualifyGlobalConstantsAndFunctions = false
				},
				phpdoc = {
					returnVoid = false,
				}
			},
		}
	})
	-- LspConfig.phpactor.setup({
	-- 	init_options = {
	-- 		["language_server_phpstan.enabled"] = true,
	-- 		["language_server_psalm.enabled"] = true,
	-- 	},
	-- 	capabilities = {
	-- 		textDocument = {
	-- 			completion = {
	-- 				completionItem = {
	-- 					snippetSupport = false
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	--
	-- })
end

return Php
