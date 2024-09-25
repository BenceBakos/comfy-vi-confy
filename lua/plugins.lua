Plugins = {}

Plugins.init = function(Package)
	-- Packages
	Package.install({
		'mfussenegger/nvim-dap',
		'aklt/plantuml-syntax',
		'weirongxu/plantuml-previewer.vim',
		'f-person/git-blame.nvim',
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim',
		'akinsho/flutter-tools.nvim',
		'preservim/tagbar'
	})

	TODO THIS
	-- Cmp lsp configs
	CmpLsp = require('cmp_nvim_lsp')

	-- LSP & autocomplete
	LspConfig = require('lspconfig')
	require('plugins.lspconfig').init(LspConfig, CmpLsp)

	-- DAP (needs mason install after config)
	local Dap = require('dap')
	require('plugins.dap').init(Dap)

	-- flutter
	local FlutterTools = require('flutter-tools')
	require('plugins.fluttertools').init(FlutterTools)
end

return Plugins
