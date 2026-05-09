cd-- () {
    cwd

    builtin cd "$(/usr/bin/dirname "${PWD}")"

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    cwd

    local murasaki
    local end
    murasaki="\033[38;5;135m"
    end="\033[m"
    echo -e "${PWD}${murasaki}${CWD_SHADOW}${end}"
}
