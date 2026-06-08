rm () {
    if [ -t 0 ]; then
        /bin/rm "$@"
    else
        while IFS='' read -r line; do
            /bin/rm "$@" -- "$line"
        done
    fi
}
