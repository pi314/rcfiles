rm () {
    if [ -t 0 ]; then
        /bin/rm "$@"
    else
        xargs -I{} /bin/rm "$@" '{}'
    fi
}
