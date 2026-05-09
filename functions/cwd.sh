cwd () {
    if [ -z "$PWD" ]; then
        return 1
    fi

    if [ -z "$CWD_TRAIL" ]; then
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    if ! startswith "$CWD_TRAIL/" "$CWD"; then
        # Derailed, realign
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''

    else
        # Update shadow
        CWD_SHADOW="${CWD_TRAIL:${#PWD}}" # substring
    fi
}
