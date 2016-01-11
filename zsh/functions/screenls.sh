screenls () {
    screen -ls | grep --color=no -o '[0-9]\+\..*(.*)' | tr '\t()' ' []' | sed "s/\([^ ][^ ]*\)  *\([^ ][^ ]*\)/\2 \1/"
}

tmuxls () {
    tmux ls | sed "/attached/ s/^\(.*\): .*$/[Attached] \1/; s/^\(.*\): .*$/[Detached] \1/"
}
