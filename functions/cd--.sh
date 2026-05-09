cd-- () {
    cwd -q

    builtin cd "$(/usr/bin/dirname "${PWD}")"

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    cwd
}
