cd-- () {
    if [ -z "$PWD" ]; then
        echo 'PWD is empty'
        return 1
    fi

    if [ -z "$CWD_PROBE" ]; then
        CWD_PROBE="$PWD"
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    case "$CWD_PROBE/" in
        "$CWD"*) ;;
        "$CWD") ;;
        *) CWD_PROBE="$PWD" ;;
    esac

    cd "$(dirname "${PWD}")"

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    case "$CWD_PROBE/" in
        "$CWD"*)
            echo -e "$PWD\033[38;5;135m${CWD_PROBE:${#PWD}}\033[m"
                ;;
        *)  echo Path incorrect
            return 1 ;;
    esac

    export CWD_PROBE
}
