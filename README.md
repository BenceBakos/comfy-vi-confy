# Comfy vi

## Abz

Type:
 - Peak
 - Entry
 - Actions
 - Macros
(All could be empty)

Macro building?
Type making?

---

Env(sh, ssh, ftp, mysql(databases), mysql(tables), docker exec)
 - entry(previous views listing gets me an identifier)
 - list
 - exit
 - check(ip available, database running, docker contanier running, command exists, file/directory exists)

---

start from a shell experience, I have to be abel to switch from abz to manual and back, so no state can exist

no state means no context, that's a problem

get executed commands, and follow path
explain last executed(into a generalized snippet/command)
show in statusline wether abz followed or not
for every context, always show possible actions

 - capture every command
    - per terminal
    - keep history
    - follow up with abz
    - show if can't follow
 - history window: 
     - only explained is stored
     - show each executed command
     - show how much those are explained or not
     - add explanation -> context follows
     - every non-explained is ignored, no context change assumed
     - close
 - based on context, show actions
     - categorized
         - context change
         - possible(binaries, ips, files all available)
         - incomplete(some bins, ips are missing)

 - action
     - process simple and complex as well
     - isContext
     - argument types(all could be figured out automatically)
         - ip
         - domain
         - path
         - switch(comment)
         - user
         - group
         - binary
         - any

TODO:
 - Command understanding
 - command parameterization
 - macros/scripting

---

 - follow command execution
 - manually sig context switch commands

---

- capture every command
     - catalog by shape -> command names -> argument types
     - manually set one as context change

---

---

```
			local options = { "apple", "banana", "cherry", "date", "fig", "grape" }

			vim.ui.input({
				prompt = 'Enter a fruit: ',
				completion = 'customlist',
			}, function(input)
				if input then
					print("You entered: " .. input)
				else
					print("No input provided")
				end
			end)

			-- Custom completion function
			function _G.fruit_complete(findstart, base)
				if findstart == 1 then
					-- Return the start position for completion
					return vim.fn.col('.') - 1
				else
					-- Return the list of options that match the base
					local matches = {}
					for _, fruit in ipairs(options) do
						if string.find(fruit, base) then
							table.insert(matches, fruit)
						end
					end
					return matches
				end
			end

			-- Set the complete function for the input
			vim.cmd('setlocal completefunc=v:lua.fruit_complete')
		end,

```

```

local options = { "Option 1", "Option 2", "Option 3" }

-- Function to show the menu
local function show_menu()
  vim.ui.select(options, {
    prompt = 'Choose an option:',
  }, function(choice)
    if choice then
      print("You selected: " .. choice)
    else
      print("No option selected")
    end
  end)
end

-- Set a key mapping for Ctrl-K to show the menu
vim.api.nvim_set_keymap('n', '<C-k>', ':lua show_menu()<CR>', { noremap = true, silent = true })
```


 - capture every command
     - build context tree
     - 
 - execute in context: autocomplete arguments based on type and history
 - explain action
 - add actions from bashhistory files
 - action
     - generic: guess argument type
     - context switch: tag by generics like bash or arch, 
     - listing: split by newline, tabs -> into table -> select colNum/rowNum/whole as id 
         - generic context based
 - 
 - macro builder(list of steps, step always starts from root, and progresses up the tree with conditions)
 - macro selector
 - test every action with which, exists, etc

