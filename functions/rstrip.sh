rstrip () {
    # Must take two strings
    if [ $# -ne 2 ]; then
        return 1
    fi

    local ret="${1%$2}"
    echo "${ret}"

    if [ "$ret" = "$1" ]; then
        return 1
    fi
}
