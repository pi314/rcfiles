screenls () {
    screen -ls | grep --color=no -o '[0-9]\+\..*(.*)' | tr '\t()' ' []' | sed "s/\([^ ][^ ]*\)  *\([^ ][^ ]*\)/\2 \1/"
}

tmuxls () {
    tmux ls -F '[#{?session_attached,Attached,Detached}] #{session_name}'
}
