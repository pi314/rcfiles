if command -v tac >/dev/null 2>&1; then
    true

else
    tac () {
        tail -r "$@"
    }
fi
