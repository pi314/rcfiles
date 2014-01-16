# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias ll='ls -al'
alias lsl='ls -l'

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
