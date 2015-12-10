ZSH_TITLE=""
title () {
    if [ "$1" = "-t" ]; then    # -t: temporary
        save_to_file=0
        shift
    else
        save_to_file=1
    fi

    ZSH_TITLE="$*"

    if [ $save_to_file -eq 0 ] || grep "^$ZSH_TITLE$" $HOME/.titles >/dev/null 2>&1; then
        true
    else
        echo "$ZSH_TITLE" >> $HOME/.titles 2>/dev/null
    fi

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

chpwd () {
    if [[ -z "$ZSH_TITLE" ]]; then
        ZSH_TITLE=$(basename $PWD)
        title -t $ZSH_TITLE
    fi
}
