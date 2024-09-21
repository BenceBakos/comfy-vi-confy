
Terminal = require("utils.terminal")

Env = {}

Env.excludeOs = {
	Terminal.TERMUX
}

Env.desktopCommands = {
	'setxkbmap -option caps:escape'
	-- unod setxkbmap :
	--    setxkbmap -option
	-- gnome solution: gnome-tweaks package
}

Env.envCommands = {
	debian = Env.desktopCommands,
	arch = Env.desktopCommands
}

return Env
