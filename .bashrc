# If not running interactively, don't do anything
[ -z "$PS1" ] && return

LS_TYPE=""
if [ `uname` == "FreeBSD" ]; then
    LS_TYPE="BSD"

elif [ `uname` == "Darwin" ]; then
    LS_TYPE="BSD"

else
    LS_TYPE="GNU"

fi

if [ $LS_TYPE == "BSD" ]; then
    alias ls='ls -G'
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
    #               1 2 3 4 5 6 7 8 9 1011
    export LSCOLORS GxFxcxDxCxegedabagacad

else
    alias ls='ls --color=auto'
    alias ll='ls -aCl --color=auto'
    alias lsl='ls -Cl --color=auto'
    # Let "ls" has pretty color
    export LS_COLORS="di=01;36:ln=01;35"

fi

# prompt setting
# color codes needs to be wrapped by \[ and \]
#  so that the length of color codes will not be calculate by terminal
# format: "{TIME}{USERNAME}@{HOST}[{PWD}]$ "
# color:  cyan, yellow, normal, blue, green, normal
PS1="\[\e[1;36m\]\A"\
"\[\e[1;33m\]\u"\
"\[\e[m\]@"\
"\[\e[1;34m\]\h"\
"\[\e[1;32m\][\w]"\
"\[\e[m\]$ "

bind '"\e[A"':history-search-backward # Use up and down arrow to search
bind '"\e[B"':history-search-forward  # the history. Invaluable!

bind '"\ej"':shell-backward-word
bind '"\ek"':shell-forward-word
