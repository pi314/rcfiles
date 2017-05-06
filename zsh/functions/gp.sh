gp () {
    if [ "$1" = '' ]; then
        echo 'Pattern ಠ_ಠ?'
        return 1
    fi

    if [ $# = 1 ]; then
        grep -n -R "$1" .
    else
        grep -n -R $@
    fi
}
