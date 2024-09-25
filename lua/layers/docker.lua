Terminal = require("utils.terminal")

Docker = {}

Docker.excludeOs = {
	Terminal.TERMUX
}

Docker.dependencyBinaries = {
	debian = { 'docker', 'docker-compose' },
	arch = { 'docker', 'docker-compose' }
}

Docker.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.dockerls.setup({})
end

return Docker
