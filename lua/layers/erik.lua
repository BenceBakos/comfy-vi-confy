Terminal = require("utils.terminal")
Package = require("utils.package")
Os = require('os')

Erik = {}

Erik.excludeOs = {
	Terminal.TERMUX
}

Erik.packages = {
	"zbirenbaum/copilot.lua",
	"nvim-lua/plenary.nvim",
	"ravitemer/mcphub.nvim",
	'stevearc/dressing.nvim',
	'MunifTanjim/nui.nvim',
	'echasnovski/mini.icons',
	'yetone/avante.nvim',
	'HakonHarnes/img-clip.nvim',
}

Erik.mcphub = nil

Erik.init = function()
	Erik.initAvante()
	Erik.initMcphub()
end

Erik.initMcphub = function()
	Erik.mcphub = Package.want("mcphub")

	if not Erik.mcphub then return false end

	Erik.mcphub.setup({
		extensions = {
			avante = {
				auto_approve_mcp_tool_calls = true, -- Auto approves mcp tool calls.
			}
		}
	})
end

Erik.initAvante = function()
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

	-- local copilot = Package.want('copilot')
	-- if not copilot then return false end
	-- copilot.setup({})

	local avanteLib = Package.want('avante_lib')
	if not avanteLib then return false end
	avanteLib.load()

	-- TODO run make
	local avante = Package.want('avante')
	if not avante then return false end
	avante.setup({
		provider = 'copilot',
		copilot = {
			model = "claude-3.7-sonnet",
		},
		behaviour = {
			auto_suggestions = false,
			auto_apply_diff_after_generation = true,
			auto_accept_diff_after_generation = true,
			support_paste_from_clipboard = true,
			use_cwd_as_project_root = true,
		},
		-- other config
		system_prompt = function()
			local hub = require("mcphub").get_hub_instance()
			return hub:get_active_servers_prompt()
		end,
		custom_tools = function()
			return {
				Package.want("mcphub.extensions.avante").mcp_tool(),
			}
		end,
	})
end

return Erik
