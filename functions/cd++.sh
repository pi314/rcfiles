cd++ () {
    local dgreen
    local red
    local murasaki
    local end
    red="\033[38;5;9m"
    dgreen="\033[0;32m"
    murasaki="\033[38;5;135m"
    end="\033[m"

    cwd

    local down
    down="${CWD_SHADOW#/}"  # lstrip leading slash
    down="${down%%/*}"      # rstrip everything after first slash

    extend=""
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
        echo "${PWD}"
        cwd
        return 0
    fi

    # The trail is gone
    if [ ! -d "$down" ]; then
        echo -e "${PWD}${red}${CWD_SHADOW}"
        CWD_TRAIL="${PWD}"
        CWD_SHADOW=''
        cwd
        return 1
    fi

    builtin cd "$down"

    cwd

    if [ -n "${extend}" ]; then
        # Trail extended
        echo -e "${PWD:0:$(( ${#PWD} - ${#extend} ))}${dgreen}${extend}${end}"
    fi

    if [ -z "${extend}" ]; then
        echo -e "${PWD}${murasaki}${CWD_SHADOW}${end}"
    fi
}
