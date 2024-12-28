# Comfy vi

## Abz

### Buffer
 - session per buffer
 - buffer name is last executed command+uuid of the session

### Methods

 - explainAction(action)
     - get parser from context, get shape, define arguments
     - get context, and parent context, filter types by context, use only types with null-context or matching context
     - when no parser, nullify shape, arguments
     - returns action table
 - matchExpression(expression,context)
     - when no parser for context, try exact match, action with singler variation
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
     - partent can not be self
 - updateContext(name,parent,entryCheckAction,exitAction, parser)
     - if currently in this context, exit(with new action)
     - if parser changed, re-parse all related actions
 - getArgumentSuggestions(expression,action,argumentPosition)
     - type's listingAction, when not null
     - from variation, where variation starts like expression
 - getArgumentSuggestionsFromOutputhistory(expression,action,argumentPosition)
     - from outputHistory, order by: type, history order
 - getActionSuggestions(expression, context)
     - mathExpression(expression,context)
     - usageCount ordered action.nextActionHistory first, then usegeCount ordered context actions
 - storeActionOutputHistory(output,context, action)
     - store in history array with context(truncate if too large), action, type
     - store without prompt(context.clearPromptPreffixAction)
     - store to action, if smaller than n, keep outputHistory unique
 - executeAction(expression, context)
     - mathExpression(expression,context)
     - sendToShell
     - storeActionOutput()
     - store if does not exists, and execution was successfull
 - nullifyAction(action)
     - nullify usageCount
     - nullify usageCount in other actions nextActionHistory
 - closeSession(sessionUuid)
     - kill process

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

### Context
 - name(unique string)
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

## GUI
 - show action output history, maybe Ill use terminal buffer

todo:
 - function/macro
    - 
 - Maybe built in logical action
 - Actions interacting with nvim api?

 -  Macros? what strucktre actions are related?
     - Start from current context, or any of it's parent context
     - update macro in nullifyAction

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
