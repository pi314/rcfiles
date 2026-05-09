cd++ () {
    cwd -q

    local down
    down="${CWD_SHADOW}${CWD_GONE}"
    down="${down#/}"    # lstrip leading slash
    down="${down%%/*}"  # rstrip everything after first slash

    extend=''
    if [ -z "$down" ]; then
        subdirs="$(find . -type d -maxdepth 1 -mindepth 1)"
        subdir_count=$(( "$(echo ${subdirs} | wc -l 2>/dev/null)" ))
        if [ $subdir_count -eq 1 ]; then
            down="${subdirs#./}"
            extend="/${down}"
        fi
    fi

    # Reaching the end of the trail
    if [ -z "$down" ]; then
        cwd
        return 0
    fi

    # The trail is gone
    if [ ! -d "$down" ]; then
        cwd
        CWD_TRAIL=''
        cwd -q
        return 1
    fi

    builtin cd "$down"

    cwd "${extend}"
}
