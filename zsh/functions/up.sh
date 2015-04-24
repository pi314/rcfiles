up () {
    if [[ $# -eq 0 ]]; then
        cd ..
    else
        cd $1
    fi
}
