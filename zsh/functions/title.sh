TITLE_FILE="$HOME/.titles"

set_title () {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$*"
        return
    fi

    if [ "$TERM" = "screen" ]; then
        printf "\033k$*\033\\"
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
    ZSH_TITLE="$*"
    if [ -z "$ZSH_TITLE" ]; then
        true
    elif grep "^$ZSH_TITLE$" $TITLE_FILE >/dev/null 2>&1; then
        true
    else
        echo "$ZSH_TITLE" >>$TITLE_FILE 2>/dev/null
    fi
}

delete_title () {
    tmp_titles=$(cat $TITLE_FILE | grep -v "^$*$")
    echo $tmp_titles >$TITLE_FILE 2>/dev/null
}

title () {
    case "$1" in
        -d) shift
            delete_title $@
            return
            ;;
        -*) shift ;;
        *)  save_title $@
    esac

    set_title $@
}
