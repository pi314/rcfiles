mkcd () {
    arg_parents=''
    arg_verbose=''
    arg_path=''

    while [ $# -ne 0 ]; do
        if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
            echo 'Usage:' >&2
            echo '  mkcd [-p|--parents] [-v|--verbose] DIRECTORY' >&2
            return 1

        elif [ "$1" = '-p' ] || [ "$1" = '--parents' ]; then
            arg_parents='-p'

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
        echo -e '\033[1;30m$\033[m' mkdir $arg_parents $arg_verbose "$arg_path"
    fi

    mkdir $arg_parents $arg_verbose "$arg_path"

    if [ ! -d "$arg_path" ]; then
        return 1
    fi

    if [ -n "$arg_verbose" ]; then
        echo -e '\033[1;30m$\033[m' cd "$arg_path"
    fi

    cd "$arg_path"
}
