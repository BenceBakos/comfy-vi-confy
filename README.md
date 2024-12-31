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

