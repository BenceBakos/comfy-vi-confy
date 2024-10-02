Terminal = require("utils.terminal")

Lua = {}

Lua.excludeOs = {
	Terminal.TERMUX
}

Lua.dependencyBinaries = {
	debian = { 'luajit' },
	arch = { 'luajit' }
}

Lua.init = function()
	local LspConfig = Package.want("lspconfig")
	local CmpNvimLsp = Package.want("cmp_nvim_lsp")
	if not LspConfig or not CmpNvimLsp then return false end

	LspConfig.lua_ls.setup({
		capabilities = CmpNvimLsp.default_capabilities(),
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT'
				},
				diagnostics = {
					globals = { 'vim'},
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					}
				}
			}
		}
	})
end

return Lua
