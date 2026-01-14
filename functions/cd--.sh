cd-- () {
    if [ -z "$CWD_PROBE" ]; then
        CWD_PROBE="$PWD"
    fi

    if [ -z "$PWD" ]; then
        return 1
    fi

    cd ..

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    case "$CWD_PROBE/" in
        "$CWD"*)
            echo "$PWD\033[38;5;135m${CWD_PROBE:${#PWD}}\033[m"
                ;;
        *)
            CWD_PROBE="$OLDPWD"
            ;;
    esac

    export CWD_PROBE
}
