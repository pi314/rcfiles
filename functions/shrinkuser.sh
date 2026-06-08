shrinkuser () {
    if [ -t 0 ]; then
        for var in "$@"; do
            echo "$1"
        done
    else
        cat
    fi | while read where; do
        if [ -n "${where}" ]; then
            if ! startswith "$where" "$HOME"; then
                echo "$where"
            else
                echo "~${where:${#HOME}}"
            fi
        fi
    done
}
