#!/bin/sh

ANCHOR_POOL=${HOME}/.anchors


a () {
    anchor "$@"
}

ag () {
    anchor -g "$@"
}


an () {
    anchor "$@"
}


anchor () {
    if [ $# -eq 0 ]; then
        _anchor_list | _anchor_tableize
        _anchor_usage
        return 1
    fi

    global=0
    op=""

    while [ 1 ]; do
        case "$1" in
            -g|--global) global=1 ;;
            -s|--set) op="${op}set" ;;
            -d|--delete) op="${op}del" ;;
            -l|--list) op="${op}list" ;;
            *) break ;;
        esac
        shift
    done

    if [ $global -eq 1 ] || [ -z "${TMUX}" ] ; then
        anchor=""
    else
        anchor=$(tmux ls -F '#{session_name}')
    fi

    if [ "${op}" = "" ]; then
        cmd="$(_anchor_sub "${anchor}" "${@}" | tr '\n' ' ')"
        if [ -t 1 ]; then
            printf "\033[1;30m%s\033[m\n" "${cmd}"
        fi
        sh -c "${cmd}"
        return $?

    elif [ "${op}" = "set" ]; then
        if [ ! -d ${ANCHOR_POOL} ]; then
            mkdir ${ANCHOR_POOL}
        fi
        pwd > ${ANCHOR_POOL}/${anchor}.anchor
        (printf "[${anchor}]^$(pwd)^\033[1;32m<-- new\033[m\n" && \
            (_anchor_list | grep -v "\[${anchor}\]")) | _anchor_tableize
        _anchor_clean
        return 0

    elif [ "${op}" = "del" ]; then
        if [ -f ${ANCHOR_POOL}/${anchor}.anchor ]; then
            rm ${ANCHOR_POOL}/${anchor}.anchor
            (printf "[${anchor}]^<\033[1;31mdeleted\033[m>\n" && \
                _anchor_list) | _anchor_tableize
            _anchor_clean
            return 0
        else
            printf "Anchor not set\n"
            _anchor_list | _anchor_tableize
            _anchor_clean
            return 1
        fi

    elif [ "${op}" = "list" ]; then
        _anchor_list | _anchor_tableize
        _anchor_clean
        return 0

    else
        _anchor_usage
    fi
}


_anchor_clean () {
    if [ ! -d ${ANCHOR_POOL} ]; then
        return 0
    fi

    if [ -z "$(ls -A1 ${ANCHOR_POOL})" ]; then
        rmdir ${ANCHOR_POOL}
    fi
    return 0
}


_anchor_list () {
    if [ ! -d ${ANCHOR_POOL} ]; then
        return 1
    fi
    ls -A1 ${ANCHOR_POOL} | \
        awk -v AP=${ANCHOR_POOL} \
        '{sub(/\.anchor$/, ""); f = AP "/" $0 ".anchor"; getline an < f; print "[" $0 "]^" an;}'
}


_anchor_usage () {
    echo 'Usage:'
    echo '  anchor [-g|--global] (-s|--setup)'
    echo '  anchor [-g|--global] (-d|--delete)'
    echo '  anchor (-l|--list)'
    echo '  anchor <command>'
}


_anchor_sub () {
    anchor="$1"
    shift

    while [ $# -ne 0 ]; do
        case "$1" in
            *" "*) token="\"$1\"" ;;
            *) token="$1" ;;
        esac
        printf "${token}\n" | sed "s|{}|$(cat ${ANCHOR_POOL}/${anchor}.anchor)|g"
        shift
    done
}


_anchor_tableize () {
    column -s ^ -t
}
