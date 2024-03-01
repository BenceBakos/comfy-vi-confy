-- https://github.com/savq/dotfiles/blob/63cf083ccfdddf58758c6c7837c60c7c651ae8e3/nvim/init.lua
-- https://github.com/savq/dotfiles/blob/63cf083ccfdddf58758c6c7837c60c7c651ae8e3/nvim/lua/pkg.lua

Log = require('utils.log')
Terminal = require('utils.terminal')

Package = {}

Package.PATH  = vim.fn.stdpath('data') .. '/site/pack/pkgs/'

Package.pkgs = {}

Package.installPackage = function (args)
	if type(args) == 'string' then args = {args} end

    local name = args.as or args[1]:match('^[%w-]+/([%w-_.]+)$')
    if name == nil then Log.log('parse', args[1]) return end

    local dir = Package.PATH .. (args.opt and 'opt/' or 'start/') .. name

	local pkg = {
        name = name,
        branch = args.branch,
        dir = dir,
		baseDir = Package.PATH .. (args.opt and 'opt/' or 'start/'),
        exists = vim.fn.isdirectory(dir) ~= 0,
        url = args.url or 'https://github.com/' .. args[1] .. '.git',
    }

	Package.pkgs[name] = pkg

	if pkg.exists then return end

    if pkg.branch then
		Terminal.runSyncIn('git clone '..pkg.url..' -b '..pkg.branch ,pkg.baseDir)
    else
		Terminal.runSyncIn('git clone '..pkg.url ,pkg.baseDir)
    end

end

Package.install = function (packageList)
	for _,args in pairs(packageList) do
		Package.installPackage(args)
	end
end

Package.update = function ()
	for _,pkg in ipairs(Package.pkgs) do
		if pkg.exists then Terminal.runIn('git pull', pkg.dir) end
	end
end

Package.clean = function ()
	Terminal.run('rm -rf '..Package.PATH..'/start/*')
	Terminal.run('rm -rf '..Package.PATH..'/opt/*')
end

return Package
