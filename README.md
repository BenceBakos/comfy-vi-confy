# Comfy vi

### Architecture

## Plugins
 - use lazy
 - plugin folder
 - setup options from triggers
 - mappable functions into utils

## Triggers
 - init, where order defined

```lua
return {
    nmap('th',':tabfirst<CR>')

    nmap(
        'th',
        cl(
            'feed',
            cl(
                'concat',
                ':tabedit',
                cl('cwd'),
                '/'
            )
        )
    )
}
```

## Utils
one function one file groupped, result verified, interfacing


### Todo

