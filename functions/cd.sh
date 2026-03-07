cd () {
    if [ -t 0 ] || [ $# -ne 0 ]; then
        builtin cd "$@"

    elif [ $# -eq 0 ]; then
        read dest
        if [ "${dest}" = '~' ]; then
            builtin cd
        else
            builtin cd "${dest}"
        fi

    fi
}
