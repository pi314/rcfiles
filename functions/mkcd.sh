mkcd () {
    if [ -n "$1" ]; then
        mkdir "$1" && cd "$1"
    fi
}
