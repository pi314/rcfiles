# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export _KERNEL_TYPE="$(/usr/bin/env uname -s)"
case $_KERNEL_TYPE in
    "FreeBSD")
        export LS_VERSION="BSD"
        ;;

    "Darwin")   # Mac OS
        export LS_VERSION="BSD"
        ;;

    "Linux")
        export LS_VERSION="GNU"
        ;;

    *)
        if [[ "$_KERNEL_TYPE" == "CYGWIN"* ]]; then
            export _KERNEL_TYPE="CYGWIN"
            export LS_VERSION="GNU"
        else
            export _KERNEL_TYPE="UNKNOWN"
            echo "Unknown OS type"
            uname -a
            export LS_VERSION="GNU"     # guess it uses GNU ls
        fi
esac

if [ $LS_VERSION == "BSD" ]; then
    alias ls='ls -CGF'
else
    alias ls='ls --color=auto'
fi
alias l='ls -l'
alias la='l -a'

#Let "ls has pretty color
# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# x     default foreground or background

# 1.   directory
# 2.   symbolic link
# 3.   socket
# 4.   pipe
# 5.   executable
# 6.   block special
# 7.   character special
# 8.   executable with setuid bit set
# 9.   executable with setgid bit set
# 10.  directory writable to others, with sticky bit
# 11.  directory writable to others, without sticky
#      bit
#                1 2 3 4 5 6 7 8 9 1011
export LSCOLORS="GxFxcxDxCxegedabagacad"
export LS_COLORS="di=01;36:ln=01;35"

# prompt setting
# color codes needs to be wrapped by \[ and \]
#  so that the length of color codes will not be calculate by terminal

black="\[\e[1;30m\]"
gray="\[\e[37m\]"
grey=${gray}
red="\[\e[1;31m\]"
green="\[\e[1;32m\]"
yellow="\[\e[1;33m\]"
blue="\[\e[1;34m\]"
purple="\[\e[35m\]"
magenta=${purple}
cyan="\[\e[1;36m\]"
white="\[\e[1;37m\]"
end="\[\e[m\]"

_last_cmd_succ () {
    if [ "$(echo $?)" -eq 0 ]; then
        printf "${black}|${end}"
    else
        printf "${red}|${end}"
    fi
}

_suspend_jobs () {
    jbs=$(jobs -p | wc -l)
    if [ $jbs -ne 0 ]; then
        printf "${blue}jobs:\j${end}"
    fi
}

if [ -n "$(command -v git)" ]; then
    # Oh yes, we really have git
    _git_info () {
        local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "$branch_name" ]; then
            # we are now in a git repo
            local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
            local repo_name=""
            if [ -n "$repo_root" ]; then
                repo_name="$(basename $repo_root):"
            fi

            if [ -f "$repo_root/.git/refs/stash" ]; then
                local stashes_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
                local stashes_stack_str=$(printf '%*s' ${stashes_count} | tr ' ' '(')
            fi

            local is_bare=$(git rev-parse --is-bare-repository 2>/dev/null)
            if [ "$is_bare" == "true" ]; then
                local color=${blue}
                branch_name='=BARE='
            elif [ -z "$(git status --porcelain 2>/dev/null)" ]; then
                # This repo is clean
                local color=${blue}
            elif [ -z "$(git status -s -uno 2>/dev/null)" ]; then
                # This repo is dirty, but no modify on tracked files
                local color=${magenta}
            else
                # This repo is dirty
                local color=${red}
            fi
            echo "${color}${stashes_stack_str}($repo_name${branch_name})${end}"
        fi
    }
else
    _git_info () {
        true
    }
fi

PROMPT_COMMAND=_gen_prompt

_gen_prompt () {
    lcs=$(_last_cmd_succ)
    gi="$(_git_info)"
    if [ -n "${gi}" ]; then
        first_line="${lcs}${gi}\n"
    else
        first_line=""
    fi
    PS1="${first_line}${lcs}${cyan}\D{%m/%d}${green}[\w]$(_suspend_jobs)${black}[\s\v]${end}\n"\
"${lcs}${cyan}\D{%H:%M}${yellow}\u${end}@${white}\h${end}\$ "
}

bind '"\e[A"':history-search-backward # Use up and down arrow to search
bind '"\e[B"':history-search-forward  # the history. Invaluable!

bind '"\ej"':shell-backward-word
bind '"\ek"':shell-forward-word


_up () {
    local cur prev opts
    COMPREPLY=()
    if [ "${COMP_CWORD}" = 1 ]; then
        opts=""
        pwd=$(pwd)
        while [ "$pwd" != "/" ]; do
            opts="$pwd $opts"
            pwd=$(dirname $pwd)
        done
        COMPREPLY=( $(compgen -W "${opts}" -S '/' -- "${COMP_WORDS[COMP_CWORD]}") )

    elif [ "${COMP_CWORD}" = 2 ]; then
        if [ ! -d "${COMP_WORDS[1]}" ]; then
            return 1
        elif [ "${COMP_WORDS[2]}" = "" ]; then
            opts=$(ls ${COMP_WORDS[1]})
            COMPREPLY=( $(compgen -W "${opts}" -- "${COMP_WORDS[2]}") )
        else
            case "${COMP_WORDS[2]}" in
                "")
                    opts=$(ls ${COMP_WORDS[1]})
                    COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
                    ;;
                */)
                    opts="$(ls ${COMP_WORDS[1]}/${COMP_WORDS[2]})"
                    COMPREPLY=( $(compgen -W "${opts}" -P "${COMP_WORDS[2]}" -S '/' -- "$cur") )
                    ;;
                *)
                    if [ "$(basename ${COMP_WORDS[2]})" = "${COMP_WORDS[2]}" ]; then
                        opts="$(ls ${COMP_WORDS[1]})"
                        COMPREPLY=( $(compgen -W "${opts}" -S '/' -- "${COMP_WORDS[2]}") )
                    else
                        opts="$(ls $(dirname ${COMP_WORDS[1]}/${COMP_WORDS[2]}))"
                        prefix="$(dirname ${COMP_WORDS[2]})/"
                        COMPREPLY=( $(compgen -W "${opts}" -P "${prefix}" -S '/' -- "$(basename ${COMP_WORDS[2]})") )
                    fi
                    ;;
            esac
        fi
    fi
    return 0
}
complete -o nospace -F _up up

if [ -f ~/.bashlocal ]; then
    source ~/.bashlocal
fi
