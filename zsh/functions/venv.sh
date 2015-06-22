venv () {
    if [ -z "$1" ]; then
        exit
    fi
    source $1/bin/activate
}

