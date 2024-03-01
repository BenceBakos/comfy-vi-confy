LuaSnipConfig = {}

LuaSnipConfig .init = function(LuaSnip)
	require('luasnip.loaders.from_vscode').lazy_load()
end

return LuaSnipConfig 
