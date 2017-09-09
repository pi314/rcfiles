gp () {
    if [ "$1" = '' ]; then
        echo 'Pattern ಠ_ಠ?'
        return 1
    fi

    if [ -t 0 ]; then
        # stdin
        grep -n $@ -R .
    else
        grep $@
    fi
}
