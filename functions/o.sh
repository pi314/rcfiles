o () {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
