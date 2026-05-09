shrinkuser () {
    if [ -n "$1" ]; then
        where="$1"
    elif [ ! -t 0 ]; then
        read where
    else
        where=''
    fi

    if [ -z "${where}" ]; then
        return 1
    fi

    if ! startswith "$where" "$HOME"; then
        echo "$where"
        return 1
    fi

    echo "~${where:${#HOME}}"
}
