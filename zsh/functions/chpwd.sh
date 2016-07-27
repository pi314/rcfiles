chpwd () {
    if [[ "$PWD" = "$OLDPWD" ]]; then
        ##########################
        # Shell Title
        ##########################
        if [[ -z "$ZSH_TITLE" ]]; then
            title -t $(basename $PWD)
        fi

        ##########################
        # Python venv
        ##########################
        if [ -f ".venv/bin/activate" ]; then
            source ".venv/bin/activate"
        fi
    fi
}
