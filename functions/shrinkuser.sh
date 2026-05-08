shrinkuser () {
    if ! startswith "$1" "$HOME"; then
        echo "$1"
        return 1
    fi

    echo "~${1:${#HOME}}"
}
