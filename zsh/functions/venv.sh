venv () {
    if [ -z "$1" ]; then
        if [ -n "$VIRTUAL_ENV" ]; then
            echo "Leave venv: $VIRTUAL_ENV"
            deactivate
            return
        else
            echo "Apply default venv: ${HOME}/.venv"
            target="${HOME}/.venv"
        fi
    else
        target="$1"
    fi
    source "${target}/bin/activate"
}

