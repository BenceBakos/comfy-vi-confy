# Comfy vi

## Abz

### Todo
 - when on phone, open new abz buffer by default with commands

### Methods
 - getArgumentsForFunction(name, module)
     - from debug, get arguments

 - getValueForConstant(name,module)
     - require and get value of constant

 - select todo 3
     - selector method used kinda everywhere
     - multi level display
     - tag selector to filter
     - upadte select history

 - input(prompt);
     - display imput field, or termux input on touch;

 - getTags

### Data
 - functions
     - name(key)
     - module(path form package.loaded,nil when complex)
     - description
     - tags(string array)
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
     - tags(string array)
     - value(not nil when custom)

 - selectHistory
     - last selected items
     - functions
     - modules


### Interface

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
     - add tag actiona(from getTags)
     - new tag action(create one with input)
     - persist action
     - display description,tags for functions
     - select argument 
         - set as argument for later choose
         - from clipboard 
         - select function
         - select select constant
     - sequence
         - select function or copy from clipboard
         - move up/down
     - delete function action
     - undo action
     - redo action
     - copy function action
    
 - displayConstant
     - select constants
     - display in new buffer(use Log.log logic to display)

 - addConstant todo 2
     - prompt for name
     - prompt for value
     - prompt for description
     - multiselect tags todo 7
     - persist;



### Possible 2.0
 - module documentation
 - handle table editing, displaying
 - buzz for interactions on phone, text to speech
 - function for context, like visual selected text, buffer(set argument as argument from context)
