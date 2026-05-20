pushd () {
    if [ -t 0 ] || [ $# -ne 0 ]; then
        builtin pushd "$@" >/dev/null

    elif [ $# -eq 0 ]; then
        read dest
        if [ "${dest}" = '~' ]; then
            builtin pushd >/dev/null
        else
            builtin pushd "${dest}" >/dev/null
        fi

    fi && dirs
}
