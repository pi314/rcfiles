chpwd () {
    if [[ "$PWD" = "$OLDPWD" ]]; then
        ##########################
        # Shell Title
        ##########################
        title -t $(basename $PWD)

        ##########################
        # Python venv
        ##########################
        if [ -f ".venv/bin/activate" ]; then
            source ".venv/bin/activate"
        fi
    fi
}
