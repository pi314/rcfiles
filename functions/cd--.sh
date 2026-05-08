cd-- () {
    if [ -z "$PWD" ]; then
        echo 'PWD is empty'
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
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    builtin cd "$(/usr/bin/dirname "${PWD}")"

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    if ! startswith "$CWD_TRAIL/" "$CWD"; then
        return 1
    fi

    CWD_SHADOW="${CWD_TRAIL:${#PWD}}"    # substring

    local murasaki
    local end
    murasaki="\033[38;5;135m"
    end="\033[m"
    echo -e "${PWD}${murasaki}${CWD_SHADOW}${end}"
}
