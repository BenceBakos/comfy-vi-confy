# Comfy vi

## Todo

 - [x] Rename lsp layer to ide
 - [ ] ~Merge too separated layers(like lsp)~ **lsps are separate because of dependency binaries**
 - [x] Replace utils with plenary, vim, or just don't wrap uselessly **Kind of done, utils are useful, cant really replace them**
 - [ ] Erik + db
 - [ ] Signature for every function
 - [ ] Looter
 - [ ] Telscope
 - [ ] Integrate db conent(snippets, commands)


## Erik + DB

### DB

#### Outline
 - nodes of infromations with tags
 - multiplle tags from the same type possible
 - tag types
     - creator computer
     - type(md/bash/code/image/credantial/url...)
     - workdir
     - repository
 - tag type crud(delete only when not used)
 - search
     - preset filters based on conditions(like repo)
     - set filters in a list of lists, up down on types, and left-right on certain items selection + clear tag type completely
 - open
     - based on type, text files in vim, media in system prompt, prep for termux as well with a reminder error message
 - create
     - set tags, some by default

#### Todo

### Erik
 - reusable prompts


## Looter
 - exceptions list
 - figure touch first, and refactor abz into touch.(just put the functionality to a cell or table)

### Scan for wifi or use current one
 - store some gps cords where wifi was available
 - store creds

### Scan for targets or use an ip
 - check network capability, scan based on that
 - optimize search(binary search or research where to look first in the range)

### Scan ports and find vulnerabilities
 - msf console or other databases, get software version
