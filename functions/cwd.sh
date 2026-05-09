cwd () {
    if [ -z "$PWD" ]; then
        return 1
    fi

    local quiet
    local extend

    # argparse start
    quiet=0
    if [ "$1" = '-q' ]; then
        quiet=1
        shift
    fi

    extend=''
    if [ -n "$1" ]; then
        extend="$1"
        shift
    fi
    # argparse end

    # Initialize CWD_TRAIL and CWD_SHADOW if didnt
    if [ -z "$CWD_TRAIL" ]; then
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    # Update shadow
    if startswith "$CWD_TRAIL/" "$CWD"; then
        CWD_SHADOW="${CWD_TRAIL:${#PWD}}" # substring
    else
        # Derailed, realign
        CWD_TRAIL="$PWD"
        CWD_SHADOW=''
    fi

    # Update CWD_GONE
    if [ ! -d "${CWD_TRAIL}" ]; then
        local probe
        probe="${CWD_TRAIL}"
        while [ ! -d "${probe}" ] && [ "${probe}" != "${PWD}" ] && [ "${probe}" != '/' ]; do
            probe="$(/usr/bin/dirname "${probe}")"
        done

        CWD_GONE="${CWD_TRAIL:${#probe}}"
        CWD_SHADOW="${probe:${#PWD}}"
    else
        CWD_GONE=''
    fi

    if [ $quiet -ne 1 ]; then
        local dgreen
        local murasaki
        local end
        local red
        red="\033[38;5;9m"
        dgreen="\033[0;32m"
        murasaki="\033[38;5;135m"
        end="\033[m"

        if [ -n "${extend}" ] && [ -z "${CWD_SHADOW}" ] && endswith "${PWD}" "${extend}" ; then
            echo -e "${PWD:0:$(( ${#PWD} - ${#extend} ))}${dgreen}${extend}${end}"
        elif [ -n "${CWD_GONE}" ]; then
            echo -e "${PWD}${murasaki}${CWD_SHADOW}${red}${CWD_GONE}${end}"
        else
            echo -e "${PWD}${murasaki}${CWD_SHADOW}${end}"
        fi
    fi
}
