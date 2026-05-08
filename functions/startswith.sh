startswith () {
    # Must take two strings
    if [ $# -ne 2 ]; then
        return 1
    fi

    # If prefix is empty, return true
    if [ -z "$2" ]; then
        return 0
    fi

    # If str is empty, return false
    if [ -z "$1" ]; then
        return 1
    fi

    case "$1" in
        "$2"*) return 0 ;;
        *) return 1 ;;
    esac
}
