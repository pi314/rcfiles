upto () {
    if [ $# -eq 0 ]; then
        echo 'Upto where ಠ_ಠ?'
        return 1
    fi

    probe="$(pwd)"
    while [ $# -gt 0 ]; do
        probe="$(dirname "${probe}")"
        while [ "$(basename "${probe}")" != "$1" ] && [ "${probe}" != '/' ]; do
            probe="$(dirname "${probe}")"
        done

        if [ "${probe}" = '/' ] && [ "$1" != '/' ]; then
            echo 'Directory not found ಠ_ಠ'
            return 1
        fi
        shift
    done

    cd "${probe}"
}
