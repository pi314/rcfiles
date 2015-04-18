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
    alias ls='ls -G'
    alias l='ls -aClG'
    alias ll='ls -aClG'
    alias lsl='ls -ClG'

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

else
    alias ls='ls --color=auto'
    alias l='ls -aCl --color=auto'
    alias ll='ls -aCl --color=auto'
    alias lsl='ls -Cl --color=auto'
    # Let "ls" has pretty color

fi

export LSCOLORS="GxFxcxDxCxegedabagacad"
export LS_COLORS="di=01;36:ln=01;35"

# prompt setting
# color codes needs to be wrapped by \[ and \]
#  so that the length of color codes will not be calculate by terminal

black="\[\e[1;30m\]"
gray="\[\e[37m\]"
grey=$gray
red="\[\e[1;31m\]"
green="\[\e[1;32m\]"
yellow="\[\e[1;33m\]"
blue="\[\e[1;34m\]"
purple="\[\e[35m\]"
magenta=$purple
cyan="\[\e[1;36m\]"
white="\[\e[1;37m\]"
end="\[\e[m\]"

_last_cmd_succ () {
    if [ "=$(echo $?)" = "=0" ]; then
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

PROMPT_COMMAND=_gen_prompt

_gen_prompt () {
    lcs=$(_last_cmd_succ)
    PS1="${lcs}${green}[\w]$(_suspend_jobs)${black}[\s\v]${end}\n"\
"${lcs}${cyan}\A${yellow}\u${end}@${white}\h${end}\$ "
}

bind '"\e[A"':history-search-backward # Use up and down arrow to search
bind '"\e[B"':history-search-forward  # the history. Invaluable!

bind '"\ej"':shell-backward-word
bind '"\ek"':shell-forward-word

mkcd () {
    mkdir $1 && cd $1
}

up () {
    if [ $# -eq 0 ]; then
        cd ..
    else
        cd $1
    fi
}

