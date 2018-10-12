#!/usr/bin/env sh

venv () {
    if [ -z "$1" ]; then
        target="${HOME}/.venv"
    else
        target="$1"
    fi

    if [ -z "$1" ] && [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    elif [ -d "${target}" ]; then
        source "${target}/bin/activate"
    else
        echo "venv not found: ${target}"
    fi
}
