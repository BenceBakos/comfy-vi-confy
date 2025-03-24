Terminal = require("utils.terminal")
Log = require("utils.log")

Copilot = {}

Copilot.model = "claude-3.7-sonnet"

Copilot.excludeOs = {}
Copilot.dependencyBinaries = {}
Copilot.envCommands = {}
Copilot.packages = {
	"zbirenbaum/copilot.lua",
	"github/copilot.vim",
	"nvim-lua/plenary.nvim"
}

--- Sends a prompt to the AI model and returns a response.
-- @param prompt_text string: The user input prompt.
-- @param options table|nil: Additional options, including model selection.
-- @return string|nil: The response from the AI model or nil on failure.
function Copilot.prompt(prompt_text, options)
	options = options or {}
	options.model = options.model or Copilot.model
	Log.log("Sending prompt to " .. options.model)

	local oauth_token = Copilot.get_oauth_token()
	if not oauth_token then
		Log.err("Failed to get OAuth token. Please make sure you are authenticated with Copilot.")
		return nil
	end

	local github_token = Copilot.authorize_token(oauth_token)
	if not github_token or not github_token.token then
		Log.err("Failed to authorize GitHub Copilot token")
		return nil
	end

	local body = {
		model = options.model,
		messages = {
			{ role = "user", content = prompt_text }
		},
		stream = false
	}

	local curl = require("plenary.curl")
	local response = curl.post("https://api.githubcopilot.com/chat/completions", {
		headers = {
			["Content-Type"] = "application/json",
			["Authorization"] = "Bearer " .. github_token.token,
			["Copilot-Integration-Id"] = "vscode-chat",
			["Editor-Version"] = "Neovim/" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
		},
		body = vim.fn.json_encode(body),
		timeout = 30000,
	})

	if response.status ~= 200 then
		Log.err("Failed to get response from Copilot: " .. vim.inspect(response))
		return nil
	end

	local json_response = vim.fn.json_decode(response.body)
	if json_response and json_response.choices and json_response.choices[1] and json_response.choices[1].message then
		return json_response.choices[1].message.content
	else
		Log.err("Failed to parse response from Copilot")
		return nil
	end
end

--- Retrieves the OAuth token for GitHub Copilot.
-- @return string|nil: The OAuth token if found, or nil otherwise.
function Copilot.get_oauth_token()
	local config_path = vim.fn.expand("$XDG_CONFIG_HOME")

	if not config_path or vim.fn.isdirectory(config_path) == 0 then
		if Terminal.getOs() == "windows" then
			config_path = vim.fn.expand("~/AppData/Local")
		else
			config_path = vim.fn.expand("~/.config")
		end
	end

	local file_paths = {
		config_path .. "/github-copilot/hosts.json",
		config_path .. "/github-copilot/apps.json",
	}

	for _, file_path in ipairs(file_paths) do
		if vim.fn.filereadable(file_path) == 1 then
			local content = vim.fn.readfile(file_path)
			if vim.islist(content) then
				content = table.concat(content, "")
			end

			local ok, data = pcall(vim.fn.json_decode, content)
			if ok then
				for key, value in pairs(data) do
					if string.find(key, "github.com") then
						return value.oauth_token
					end
				end
			end
		end
	end

	return nil
end

--- Authorizes the OAuth token and retrieves a GitHub Copilot token.
-- @param oauth_token string: The OAuth token to authorize.
-- @return table|nil: The authorized token data or nil on failure.
function Copilot.authorize_token(oauth_token)
	local curl = require("plenary.curl")
	local response = curl.get("https://api.github.com/copilot_internal/v2/token", {
		headers = {
			["Authorization"] = "token " .. oauth_token,
			["Accept"] = "application/json",
		},
	})

	if response.status == 200 then
		return vim.fn.json_decode(response.body)
	else
		Log.err("Failed to authorize token: " .. vim.inspect(response))
		return nil
	end
end

--- Initializes the Copilot plugin.
function Copilot.init()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})

	vim.api.nvim_create_user_command("Prompt", function(opts)
		local prompt_text = opts.args
		if prompt_text and prompt_text ~= "" then
			local response = Copilot.prompt(prompt_text)
			if response then
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
				vim.api.nvim_command("vsplit")
				vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf)
				vim.api.nvim_buf_set_option(buf, "modifiable", false)
				vim.api.nvim_buf_set_name(buf, "Copilot Response")
			end
		else
			print("Please provide a prompt")
		end
	end, { nargs = "+" })
end

Copilot.options = { g = {}, opt = {} }
Copilot.commands = {}
Copilot.autocmds = {}
Copilot.maps = {}

return Copilot

