TITLE_FILE="$HOME/.titles"

set_title () {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$*"
        return
    fi

    if [ "$TERM" = "screen" ]; then
        printf "\033k$*\033\\"
        return
    fi

    case $ZSH_KERNEL_TYPE in
        "CYGWIN")
            printf "\033]0;$*\007"
            ;;
        *)
            printf "\033]1;$*\a"
    esac
}

save_title () {
    local ZSH_TITLE="$*"
    if [ -z "$ZSH_TITLE" ]; then
        true
    elif grep "^$ZSH_TITLE$" $TITLE_FILE >/dev/null 2>&1; then
        true
    else
        echo "$ZSH_TITLE" >>$TITLE_FILE 2>/dev/null
    fi
}

delete_title () {
    local tmp_titles=$(cat $TITLE_FILE | grep -v "^$*$")
    echo $tmp_titles >$TITLE_FILE 2>/dev/null
}

print_usage () {
    echo 'Usage:'
    echo '  title -h'
    echo '  title [-d|-t] <title-str>'
    echo ''
    echo 'Optional arguments:'
    echo "  -d    delete <title-str> from $HOME/.titles"
    echo "  -t    set title to <title-str> but not saving it to $HOME/.titles"
}

title () {
    case "$1" in
        -d) shift
            delete_title $@
            return
            ;;
        -h) print_usage
            return
            ;;
        -t) shift ;;
        -*) shift ;;
        *)  save_title $@
    esac

    set_title $@
}
