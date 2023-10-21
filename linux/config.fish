if status is-interactive
    # Commands to run in interactive sessions can go here
end

function cljvim
    env NVIM_APPNAME=cljvim nvim
end

function lzyvim
    env NVIM_APPNAME=lzyvim nvim
end

function vim
    set items cljvim lzyvim
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [ -z $config ]
        echo "Nothing selected"
        return 0
    else if [ $config = "default" ]
        set config ""
    end
    env NVIM_APPNAME=$config nvim $argv
end
bind \ca 'vim\n'```

starship init fish | source
