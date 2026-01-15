cd++ () {
    if [ -z "$CWD_PROBE" ]; then
        echo 'CWD_PROBE is empty'
        return 1
    fi

    if [ -z "$PWD" ]; then
        echo 'PWD is empty'
        return 1
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    case "$CWD_PROBE/" in
        "$CWD"*)
            down="${CWD_PROBE:${#PWD}}" # substring
            down="${down#/}"            # trim leading slash
            down="${down%%/*}"          # trim everything after first slash

            if [ -d "$down" ]; then
                cd "$down"
            fi

            echo -e "$PWD\033[38;5;135m${CWD_PROBE:${#PWD}}\033[m"
            ;;
        *)
            echo 'CWD_PROBE does not under PWD'
            return 1
            ;;
    esac
}
