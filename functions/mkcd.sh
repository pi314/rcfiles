mkcd () {
    dollar="\033[38;5;135m$\033[m"

    arg_verbose=''
    arg_path=''

    while [ $# -ne 0 ]; do
        if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
            echo 'Usage:' >&2
            echo "${dollar}"' mkcd [-v|--verbose] DIRECTORY' >&2
            return 1

        elif [ "$1" = '-v' ] || [ "$1" = '--verbose' ]; then
            arg_verbose='-v'

        elif [ -z "$arg_path" ]; then
            arg_path="$1"

        else
            mkcd --help
            return 1
        fi

        shift
    done

    if [ -z "$arg_path" ]; then
        mkcd --help
        return 1
    fi

    if [ -n "$arg_verbose" ]; then
        echo "${dollar}" mkdir $arg_verbose "$arg_path"
    fi

    mkdir $arg_verbose -p "$arg_path"

    if [ ! -d "$arg_path" ]; then
        return 1
    fi

    if [ -n "$arg_verbose" ]; then
        echo "${dollar}" cd "$arg_path"
    fi

    cd "$arg_path"
}
