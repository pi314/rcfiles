cd++ () {
    if [ -z "$PWD" ]; then
        echo 'PWD is empty'
        return 1
    fi

    if [ -z "$CWD_PROBE" ]; then
        CWD_PROBE="$PWD"
    fi

    if [ "$PWD" = '/' ]; then
        CWD="/"
    else
        CWD="$PWD/"
    fi

    case "$CWD_PROBE/" in
        "$CWD"*) ;;
        "$CWD") ;;
        *) CWD_PROBE="$PWD" ;;
    esac

    case "$CWD_PROBE/" in
        "$CWD"*)
            down="${CWD_PROBE:${#PWD}}" # substring
            down="${down#/}"            # trim leading slash
            down="${down%%/*}"          # trim everything after first slash

            new=""
            if [ -z "$down" ]; then
                subdirs="$(find . -type d -depth 1 -maxdepth 1)"
                subdir_count="$(echo ${subdirs} | wc -l | tr -d ' ' 2>/dev/null)"
                if [ "$subdir_count" = "1" ]; then
                    down="${subdirs#./}"
                    new="\033[32m/${down}\033[m"
                fi
            fi

            if [ -z "$down" ]; then
                gone=0
                color=""
            elif [ -d "$down" ]; then
                cd "$down"
                gone=0
                color="\033[38;5;135m"
            else
                gone=1
                color="\033[38;5;9m"
            fi

            if [ -n "${new}" ]; then
                echo -e "${CWD_PROBE}${new}"
                CWD_PROBE="${PWD}"
            else
                echo -e "${PWD}${color}${CWD_PROBE:${#PWD}}\033[m${new}"
            fi

            if [ $gone -eq 1 ]; then
                CWD_PROBE="${PWD}"
            fi
            ;;
    esac

    export CWD_PROBE
}
