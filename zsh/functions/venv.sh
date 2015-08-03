venv () {
    if [ -z "$1" ]; then
        echo "Apply default venv: ${HOME}/.venv"
        target="${HOME}/.venv"
    else
        target="$1"
    fi
    source "${target}/bin/activate"
}

