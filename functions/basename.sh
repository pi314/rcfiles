basename () {
    if [ -t 0 ]; then
        /usr/bin/basename "$@"
    else
        while IFS='' read -r line; do
            /usr/bin/basename -- "$line"
        done
    fi
}
