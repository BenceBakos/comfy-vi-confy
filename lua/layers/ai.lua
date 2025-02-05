Terminal = require("utils.terminal")
Package = require("utils.package")
Os = require('os')

Ai = {}

Ai.excludeOs = {
	-- Terminal.TERMUX
}

Ai.packages = {
	'MeanderingProgrammer/render-markdown.nvim',
	'stevearc/dressing.nvim',
	'MunifTanjim/nui.nvim',
	'echasnovski/mini.icons',
	'zbirenbaum/copilot.lua',
	'yetone/avante.nvim',
	'HakonHarnes/img-clip.nvim',
}

Ai.init = function()
	local imgClip = Package.want('img-clip')

	if not imgClip then return false end

	imgClip.setup({
		default = {
			embed_image_as_base64 = false,
			prompt_for_file_name = false,
			drag_and_drop = {
				insert_mode = true,
			},
		}
	})

	local copilot = Package.want('copilot')
	if not copilot then return false end
	copilot.setup({})

	local renderMarkdown = Package.want('render-markdown')
	if not renderMarkdown then return false end
	renderMarkdown.setup({})

	local avanteLib = Package.want('avante_lib')
	if not avanteLib  then return false end
	Log.log(avanteLib)
	avanteLib.load()

	-- TODO run make
	local avante = Package.want('avante')
	if not avante then return false end
	avante.setup({
		provider = 'copilot',
		suggestion = {
			debounce = 1000
		}
	})

end

Ai.maps = {

}

return Ai
