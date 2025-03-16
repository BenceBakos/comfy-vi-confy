Terminal = require("utils.terminal")
Package = require("utils.package")
Os = require('os')

Ai = {}

Ai.excludeOs = {
	-- Terminal.TERMUX
}

Ai.packages = {
	'stevearc/dressing.nvim',
	'MunifTanjim/nui.nvim',
	'echasnovski/mini.icons',
	'zbirenbaum/copilot.lua',
	'olimorris/codecompanion.nvim',
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

	local codecompanion = Package.want('codecompanion')
	if not codecompanion then return false end
	codecompanion.setup({
		allday = { -- CodeCompanion AI
			model = "claude-3-5-sonnet",
			temperature = 0,
			streaming = true,
			show_prompt = false, -- Hide the prompt sent to the AI
			auto_insert = false, -- Toggle auto insertion of text when there is only one edit
			ui = {
				popup = {
					border = "rounded",
					width = 100,
					height = 20,
				},
			},
		},
		layouts = {
			new_tab = {
				prompt = "left", -- The query prompt at the left
				completion = "right", -- The AI completion at the right
			},
		},
		keymaps = {
			-- These should match the keymaps we defined in Ai.maps
			-- Enable explicitly mapped keybindings
			accept_diff = "<C-y>",     -- Accept the diff
			reject_diff = "<C-n>",     -- Reject the diff
			actions = "gh",            -- Show the actions in a hover panel
			toggle_diff = "<Leader>d", -- Toggle the diff view
			next_diff = "]c",          -- Jump to the next diff hunk
			prev_diff = "[c",          -- Jump to the previous diff hunk
			cancel = "<C-c>",          -- Cancel the action
		},
	})
end

Ai.maps = {
	{ mode = { "n" }, map = "gh", to = function() require("codecompanion").actions() end },
	{ mode = { "n" }, map = "<Leader>aa", to = function() require("codecompanion").toggle() end },
	{ mode = { "n" }, map = "<Leader>ae", to = function() require("codecompanion").chat({ args = "I'm finished with my answer. Please insert it at my cursor position." }) end },
}

return Ai
