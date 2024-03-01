-- DEPENDENCIES
-- git
-- fd
-- ripgrep
-- xclip
-- cargo
-- node
-- php
-- composer
-- tree-sitter
-- phpactor (https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation)

-- Todo:
-- finish outsourvce
-- treesitter possible configs
-- other good plugins

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Package = require("utils.packages")

Enviornment = require('enviornment')
Enviornment.init(Terminal)

Plugins = require("plugins")
Plugins.init(Package)

Options = require("options")
Options.init()

Commands = require("commands")
Commands.init(Keyboard)

AutoCommands = require("autocommands")
AutoCommands.init()

Mappings = require("mappings")
Mappings.init(Hop,Keyboard,Log)


