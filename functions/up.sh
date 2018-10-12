up () {
    if [[ $# -eq 0 ]]; then
        cd ..
    elif [[ $# -eq 1 ]] && [[ "$1" = '-P' ]]; then
        cd -P ..
    else
        cd $1
    fi
}
