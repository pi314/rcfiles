cd++ () {
    if [ -z "$PWD" ]; then
        echo 'PWD is empty'
        return 1
    fi

    if [ -z "$CWD_TRAIL" ]; then
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    # Derailed, realign
    if ! startswith "$CWD_TRAIL/" "$CWD"; then
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    local down
    down="${CWD_SHADOW#/}"  # lstrip leading slash
    down="${down%%/*}"      # rstrip everything after first slash

    new=""
    if [ -z "$down" ]; then
        subdirs="$(find . -type d -maxdepth 1 -mindepth 1)"
        subdir_count=$(( "$(echo ${subdirs} | wc -l 2>/dev/null)" ))
        if [ $subdir_count -eq 1 ]; then
            down="${subdirs#./}"
            new="\033[32m/${down}\033[m"
        fi
    fi

    # Reaching the end of the trail
    if [ -z "$down" ]; then
        echo "${PWD}"
        CWD_SHADOW=''
        return 0
    fi

    # The trail is gone
    if [ ! -d "$down" ]; then
        echo -e "${PWD}\033[38;5;9m${CWD_SHADOW}"
        CWD_TRAIL="${PWD}"
        CWD_SHADOW=''
        return 1
    fi

    builtin cd "$down"

    CWD_SHADOW="${CWD_SHADOW#/}"    # lstrip leading slash (may or may not present)
    CWD_SHADOW="${CWD_SHADOW:${#down}}"   # lstrip first component

    local murasaki
    local end
    murasaki="\033[38;5;135m"
    end="\033[m"

    if [ -n "${new}" ]; then
        # Trail extended
        echo -e "${CWD_TRAIL}${new}"
        CWD_TRAIL="${PWD}"
    else
        echo -e "${PWD}${murasaki}${CWD_SHADOW}${end}${new}"
    fi
}
