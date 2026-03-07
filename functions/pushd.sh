pushd () {
    if [ -t 0 ] || [ $# -ne 0 ]; then
        builtin pushd "$@"

    elif [ $# -eq 0 ]; then
        read dest
        if [ "${dest}" = '~' ]; then
            builtin pushd
        else
            builtin pushd "${dest}"
        fi

    fi
}
