Enviornment = {}

Enviornment.init = function(Terminal)
	-- capslock to escape in x
	-- unod setxkbmap :
	--    setxkbmap -option
	Terminal.run('setxkbmap -option caps:escape')
	-- gnome solution: gnome-tweaks package
end

return Enviornment
