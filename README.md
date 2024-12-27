# Comfy vi

## Abz

### Methods

 - explainAction(action)
     - get parser from context, get shape, define arguments
     - get context, and parent context, filter types by context, use only types with null-context or matching context
     - when no parser, nullify shape, arguments
     - returns action table
 - matchExpression(expression,context)
     - when no parser for context, try exact match, action with singler variation
     - when created, explainAction
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
 - getSuggestions(expression,action,argumentPosition)
     - type's listingAction, when not null
     - from variation, where variation starts like expression

### Action
 - name(expression with arguments replaced with type names, or just single variation with uuid )
 - shape(from treesitter, nullable)
 - context(context.name)
 - toContext(context.name,nullable)
 - arguments
     - position(order)
     - type(IP,domain...)
 - variations(expression string list)

### Context
 - name(unique string)
 - parent(nullable, context.name)
 - entryCheckAction(action.name)
 - exitAction(action.name)
 - parser(nullable, tresitter parser name)

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

read it until you find every gap, missing peace
 - graph? Macros? what strucktre actions are related?
 - gui/interface
 - Persistent input on gui might be stupid
 - Helpers into utils(aboid making new module)
