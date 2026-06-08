dirname () {
    if [ -t 0 ]; then
        /usr/bin/dirname "$@"
    else
        while IFS='' read -r line; do
            /usr/bin/dirname -- "$line"
        done
    fi
}
