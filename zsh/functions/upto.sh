upto () {
    if [ $# -eq 0 ]; then
        echo 'Upto where ಠ_ಠ?'
        return 1
    fi

    probe="$(dirname "$(pwd)")"
    while [ "$(basename "${probe}")" != "$1" ] && [ "${probe}" != '/' ]; do
        probe="$(dirname "${probe}")"
    done

    if [ "${probe}" = '/' ] && [ "$1" != '/' ]; then
        echo 'Directory not found ಠ_ಠ'
        return 1
    fi

    cd "${probe}"
}
