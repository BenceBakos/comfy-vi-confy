# Comfy vi

## Abz

### Methods

 - matchExpression(expression,context)
     - find action by context and shape, or create one(no persistence)
 - expressionToAction(expression): 
     - analyseExpression(expression,context) -> persist returned action
     - on creation, explain(fill toContext, review arguments)
 - createType(name,order, checkAction)
     - set order, shift types after it
     - review all action's current type, set this type, when matches
 - createContext(name,parent,entryCheckAction,exitAction)

### Action
 - name(expression with arguments replaced with type names)
 - shape(from treesitter)
 - context(context.name)
 - toContext(context.name,nullable)
 - arguments
     - position(order)
     - type(IP,domain...)
 - variations(expression string list)

### Context
 - name(unique string)
 - parent(nullable, context.name) -> can't be self
 - entryCheckAction(action.name) -> check entry was successful
 - exitAction(action.name)

### Type
 - name(unique string)
 - order(int,unique)
 - checkAction(action.name)

 - example types:
    - Path
    - Ip
    - Domain
    - Number
    - Flag
    - Switch
    - Text
