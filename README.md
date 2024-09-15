# Nvim conf

## Ideas
 - Ordered modules, with parameters and init fn
 - Parameters are 
    - settings
    - maps
    - cmds
    - autocmds
    - depencenices like packages and plugins
    - conditions like os.
 - Deps resolved os specific way(different package name)
 - Utils are inner dependencies
 - Logs table show in buffer with cmd
 - Check for missing deps and show script to resolve them in a terminal window

## Stru
 - utils
     - file
     - keyborad
     - log
     - packages
     - terminal
         - check os
 - modules
     - module template file
        - init fn
        - settings
        - maps
        - cmds
        - autocmds
        - depencenices like packages and plugins
        - conditions like os.
 - init
     - check all packages: create cmd which opens terminal with dep resolving command
     - check all plugins: install new ones, and type in ':qa!', or cntinue
     - iterate modules
         - write logs regarding steps succeeded
         - check os inclusion
         - init fn
         - options
         - cmds
         - autocmds
         - mappings

