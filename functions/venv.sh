venv () {
    if [ -n "$1" ]; then
        target="$1"
    elif [ -d '.venv' ]; then
        target='.venv'
    elif [ -d 'venv' ]; then
        target='venv'
    else
        target="${HOME}/.venv"
    fi

    murasaki="\033[38;5;135m"
    nocolor="\033[m"

    if [ ! -d "${target}" ]; then
        echo "Creating venv ${murasaki}${target}${nocolor} ..."
        python -m venv "${target}"
        returncode=$?
        if [ $returncode -eq 0 ]; then
            echo "Creating venv ${murasaki}${target}${nocolor} ... done"
        else
            echo "Creating venv ${murasaki}${target}${nocolor} ... failed"
            exit $returncode
        fi
    fi

    if [ -z "$1" ] && [ -n "${VIRTUAL_ENV}" ]; then
        deactivate
    elif [ -d "${target}" ]; then
        source "${target}/bin/activate"
    else
        echo "venv not found: ${target}"
    fi
}
