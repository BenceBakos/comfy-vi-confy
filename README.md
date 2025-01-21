# Comfy vi

## Abz

### Todo
 - when on phone, open new abz buffer by default with commands

### Methods
 - getArgumentsForFunction(name, module)
     - from debug, get arguments

 - getValueForConstant(name,module)
     - require and get value of constant

 - select
     - selector method used kinda everywhere
         - multi level display
         - name, details(keep it multiline even if just a name)
         - disabled items
     - upadte select history

 - input(prompt);
     - display imput field, or termux input on touch;

### Data
 - functions
     - name(key)
     - module(path form package.loaded,nil when complex)
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
     - persist action
     - display description, for functions
     - select argument 
         - set as argument for later choose
         - from clipboard 
         - select function
         - select constant
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

 - addConstant
     - prompt for name
     - prompt for value
     - prompt for description
     - persist;

### Render

 - container(list)
     - height
     - children(anything but container)

 - table
     - recursive list of actions, 

 - verticalContanier

 - action

 - content


### Possible 2.0
 - module documentation
 - handle table editing, displaying
 - buzz for interactions on phone, text to speech
 - function for context, like visual selected text, buffer(set argument as argument from context)
 - tags?

coladd
line 

---

 - Scroll frequency(fire for eveey third or forth event);
 - Generelize oil like tui for trees like table, fs. Now I fan use it fo build comnands from history and such
 - shared storage

### Cells

Cursor;
Enter;

Line;
Edit line

Tabs;
New tab(discovery window)

Windows;
Close buffer;

Indents;
Backspace;

Change history;
Save;

Command history(show in statusline)
Execute selected command

Move inline;
Visual select on/off;



Todo:
 - set up shared storage(find possible solution instead of syncthing)
 - interactions for table view
     - `<CR>` for leaf items
 - new buffer: table view with interactions
     - open oil
     - open shared storage in oil
 - magic(command builder, OR lua builder)
     - interactions for displayed json
     - magic
     - magic magic magic
