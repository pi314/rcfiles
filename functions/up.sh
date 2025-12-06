_up_help () {
    dollar="\033[38;5;135m$\033[m"
    echo 'Usage:'
    echo "${dollar}" 'up -h             -- show this help page and exit'
    echo "${dollar}" 'up                -- same as cd ..'
    echo "${dollar}" 'up dir            -- cd up to folder named dir'
    echo "${dollar}" 'up dir subdir     -- cd up to folder named dir, then cd to subdir'
    echo "${dollar}" 'up /some/path     -- same as cd /some/path'
    echo "${dollar}" 'up /some/path dir -- same as cd /some/path/dir'
}


up () {
    if [ "$1" = '-h' ] || [ $# -gt 2 ]; then
        _up_help
        return 1
    fi

    if [ $# -eq 0 ]; then
        cd ..
        return
    fi

    case "$1" in
        /*)
            cd "$1/$2"
            ;;
        *)
            probe="$(pwd)"
            probe="$(dirname "${probe}")"
            while [ "$(basename "${probe}")" != "$1" ] && [ "${probe}" != '/' ]; do
                probe="$(dirname "${probe}")"
            done

            if [ "${probe}" = '/' ] && [ "$1" != '/' ]; then
                echo 'Directory not found ಠ_ಠ'
                return 1
            fi

            cd "${probe}/$2"
            ;;
    esac
}
