rm () {
    if [ -t 0 ]; then
        /bin/rm "$@"
    else
        tr '\n' '\0' | xargs -0 -I{} /bin/rm "$@" '{}'
    fi
}
