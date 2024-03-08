LspConfigConfig = {}

LspConfigConfig.init = function(LspConfig,CmpLsp)
	-- Extend cmp capabilities
	local lspDefaults = LspConfig.util.default_config

	lspDefaults.capabilities = vim.tbl_deep_extend(
		'force',
		lspDefaults.capabilities,
		CmpLsp.default_capabilities()
	)


	-- configure language servers (needs installation with mason after config)
	LspConfig.lua_ls.setup({
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- https://github.com/williamboman/mason-lspconfig.nvim
	-- lspconfig.pylsp.setup({})
	-- lspconfig.intelephense.setup({
	--    init_options = {
	--        licenceKey = File.get_intelephense_license()
	--    }
	--})
	LspConfig.phpactor.setup({
		init_options = {
			["language_server_phpstan.enabled"] = false,
			["language_server_psalm.enabled"] = false,
		},
	})


	LspConfig.tailwindcss.setup({})
	LspConfig.bashls.setup({})
	LspConfig.quick_lint_js.setup({})
	LspConfig.cssls.setup({})
	LspConfig.dockerls.setup({})
	LspConfig.lemminx.setup({})
	LspConfig.yamlls.setup({})
	LspConfig.rnix.setup {}
	LspConfig.tsserver.setup {}
	LspConfig.jedi_language_server.setup {}

end

return LspConfigConfig
