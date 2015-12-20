TITLE_FILE="$HOME/.titles"
set_title () {
    if [ -n "$TMUX" ]; then
        tmux rename-window "$*"
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
    ZSH_TITLE="$*"
    if [ -z "$ZSH_TITLE" ]; then
        true
    elif grep "^$ZSH_TITLE$" $TITLE_FILE >/dev/null 2>&1; then
        true
    else
        echo "$ZSH_TITLE" >>$TITLE_FILE 2>/dev/null
    fi
}

title () {
    case "$1" in
        -d) # delete a title from .titles
            shift
            backup=$(cat $TITLE_FILE | grep -v "^$*$")
            echo $backup >$TITLE_FILE 2>/dev/null
            ;;
        -*) shift ;;
        *)  save_title $@
    esac
    set_title $@
}

chpwd () {
    if [[ -z "$ZSH_TITLE" ]]; then
        ZSH_TITLE=$(basename $PWD)
        title -t $ZSH_TITLE
    fi
}
