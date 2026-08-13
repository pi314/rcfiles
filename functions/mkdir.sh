mkdir () {
    if [ -t 0 ]; then
        command mkdir "$@"
    else
        while IFS='' read -r line; do
            command mkdir "$@" -- "$line"
        done
    fi
}
