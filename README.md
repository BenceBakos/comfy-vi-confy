# Comfy vi

## Abz

### Buffer
 - session per buffer
 - buffer name is last executed command+uuid of the session


## GUI
 - :createContext,:updateContext,:createType,:updateType -> commands, use menus, autocomplete(ordered) 
 - close tab -> closeSession
 - current context(root parent, child)

 - history(readonly buffer):
     - expression, context, output(truncated)
     - y, touch on output -> yanks full output

## Methods

 - explainAction(action)
     - get parser from context, get shape, define arguments
     - get context and parent context, filter types by context, use only types with null-context or matching context, or lua context
     - createContext, if new context is created
     - when no parser, nullify shape, arguments
     - returns action table
 - matchExpression(expression,context)
     - check for shape, when no parser for context, try exact match, action with singler variation
     - when not found, and just created, explainAction
     - find action by context and shape(if no shape, then exact string match by variation), or create one(no persistence)
 - expressionToAction(expression,context): 
     - analyseExpression(expression,context) -> persist returned action
     - on creation, explainAction(fill toContext)

 - createType(name,order, checkAction)
     - set order, shift types after it
     - review all action's current type, set this type, when matches
 - updateType(name, order, checkAction)
     - review all action's current types, overwrite argument types

 - createContext(name,parent,entryCheckAction,exitAction, parser)
     - auto install parser
     - randomly assign color
     - partent can not be self
 - updateContext(name,parent,entryCheckAction,exitAction, parser)
     - if currently in this context, exit(with new action)
     - if parser changed, re-parse all related actions

 - getArgumentSuggestions(expression,action,argumentPosition)
     - type's listingAction, when not null
     - from variation, where variation starts like expression
 - getArgumentSuggestionsFromHistory(expression,action,argumentPosition)
     - from history, order by: type, history order

 - getActionSuggestions(expression, context)
     - mathExpression(expression,context)
     - usageCount ordered action.nextActionHistory first, then usegeCount ordered context actions
     - add lua actions as well
     - return table with keys for specific kind of actions
 - getMactorSuggestions(expression, context)

 - storeActionHistory(output,context, action)
     - store in history array with context(truncate if too large), action, type
     - store without prompt(context.clearPromptPreffixAction)
     - store to action, if smaller than n, keep history unique

 - executeAction(expression, context)
     - mathExpression(expression,context)
     - sendToShell
     - storeActionHistory()
     - store if does not exists, and execution was successfull

 - nullifyAction(action)
     - nullify usageCount
     - nullify usageCount in other actions nextActionHistory

 - closeSession(sessionUuid)
     - kill process

 - createMacro(name,context, macroItems)
 - executeMacro(macro.name, context, arguments)
     - check context is valid
     - arguments: argument path in macroItems -> value
     - fill arguments into actions while executing
     - executeAction for each, or executeMacro

## Models

### HistoryItem
 - actionName
 - macroName
 - expression 
 - contextName
 - output
 - type

### Action
 - name(expression with arguments replaced with type names, or just single variation with uuid )
 - shape(from treesitter, nullable)
 - context(context.name)
 - toContext(context.name,nullable) -> filled when action switches context
 - usageCount
 - arguments
     - position(order)
     - type(IP,domain...)
 - variations(expression string list)
 - nextActionHistory
     - action.name
     - usageCount
 - outputHistory(string array of outputs)

### Macro
 - name
 - context
 - macroItems

### MacroItem
 - actionName
 - macroName
 - arguments

### Context
 - name(unique string)
 - color(randomly assigned)
 - parent(nullable, context.name)
 - entryCheckAction(action.name)
 - exitAction(action.name)
 - parser(nullable, tresitter parser name)
 - clearPromptPreffixAction(action.name)

### Type
 - name(unique string)
 - order(int,unique)
 - checkAction(action.name)
 - listingAction(action.name)
 - context(nullable)

 - example types:
    - Path
    - Url(with ip, protocol, anything like that)
    - Address(could be both an ip or a domain)
    - Ip
    - Number
    - email
    - Flag
    - Switch
    - Text


todo:
 - gui/interface
 - Persistent input on gui might be stupid
 - execution, shell process creation and such
 - Helpers into utils(aboid making new module)


## Snippets

eval string
```lua
local function eval_string(code)
    local func, err = load(code)
    if not func then
        print("Error loading code: " .. err)
        return nil
    end
    return func() -- Call the compiled function
end

```


---



Possible arguments are part of the resolution
multiple source for possible arguments

---

## GUI
 - zoom in/out -> shows +/-1 level from surface table
 - move cursor for scroll on right, zoom on left
 - execute command
 - build from command
 - start macro
 - finish macro
 - show possible errors

```
Cd ..
   <mentionedExistingDirectories>
Ssh <mentionedTypeIP>
    <matchingPreviousComandResults>
Docker ps
       Exec -it <availableContainers>
```


## Data

### Surface
 - key(expression itself, or name of the thing)
 - value
     - type(expression, )

### Macro

### Type

## Control


 - table editor
 - executor(bash or lua)
 - make all this touch friendly
 - executor does it's thing for values
 - combine values in some way?
 - describe automation in seid table as well


show that table


---

table
channels
pipes
 - stdin
 - stdout
 - stderr
 - lua in/out

---

Persistency

Controll

IO

--- 

 - per buffer workflow
 - when on phone, open new abz buffer by default

## Methods
 - getArgumentsForFunction(name, module)
     - from debug, get arguments
 - getValueForConstant(name,module)
     - require and get value of constant
 - select
     - selector method used kinda everywhere
     - multi level display
 - input(prompt)
     - display imput field, or termux input on touch

## Data
 - functions
     - name(key)
     - module(path form package.loaded,nil when complex)
     - getArguments() returns arguments when complex
     - description
     - arguments
        - not nil when complex
        - ordered string list
     - body
        - not nil when complex
        - describes functions calling each other
 - constants
     - name(module+name -> key)
     - module(path form package.loaded,nil when custom)
     - description
     - getValue() returns value when custom
     - value(not nil when custom)

 - selectHistory
     - last selected items
     - functions
     - modules

## Interface

 - employFunction
     - select module -> choose
     - select function, if table, select functions in table(multi level select)(argumnets as well, disable already employed itmes) -> choose
         - preview: open file and go to exact pos
     - persist functions

 - employConstant
     - select module
     - select constant from module, if table, choose table, or select costant in that(multi level select)(name, value, disable already employed items) -> choose
         - preview: open file and go to exact pos
     - persist constants

 - build
     - select function
     - execute action if complete
     - add descripiton action
     - store action
     - display description for functions
     - select argument 
         - set as argument for later choose
         - from clipboard 
         - select function
     - delete function action
     - undo action
     - redo action
     - copy function action
    
 - displayConstant
     - list constants -> choose one
     - display in new buffer(use Log.log logic to display)

 - addConstant
     - prompt for name
     - prompt for value
     - prompt for description
     - persist


