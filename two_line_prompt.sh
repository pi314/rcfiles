#[{pwd}][{window_name} {window_index}]({branch_name})
#{time}{username}@{hostname}> {cursor here}

printf "\n\n\n"
printf "\033[1;30m|\033[1;32m[`pwd`]\033[m\n"
printf "\033[1;30m|\033[1;36m20:38\033[1;33mpi314\033[m"
printf "@\033[1;37mcychih-PC\033[1;30m[tcsh]\033[m> \n"

printf "\n\n\n"
printf "\033[1;31m|\033[1;32m[`pwd`]\033[m(master)\033[1;34mj:3\n"
printf "\033[1;31m|\033[1;36m20:38\033[1;33mroot\033[m"
printf "@\033[1;37mcychih-PC\033[1;30m[tcsh]\033[1;35m[screen W1]\033[m# \n"

printf "\n\n\n"
printf "\033[1;30m=\033[1;31m=\033[1;32m=\033[1;33m=\033[1;34m="
printf "\033[1;35m=\033[1;36m=\033[1;37m=\033[m"

printf "\n\n\n"

printf "|[/home/cychih/.rcfiles]\n"
printf "|20:38pi314@cychih-PC[`echo $SHELL | rev | cut -d'/' -f1 | rev`]> \n"
printf "\n\n"

#alias update_git_repo_flag "set git_repo_flag=${git_repo_flag}a"

set black='%{^[[1\;30m%}'
set red='%{^[[1\;31m%}'
set green='%{^[[1\;32m%}'
set yellow='%{^[[1\;33m%}'
set blue='%{^[[1\;34m%}'
set purple='%{^[[1\;35m%}'
set cyan='%{^[[1\;36m%}'
set white='%{^[[1\;37m%}'
set end='%{^[[m%}'
set quote='"\""'

set _cs1='`sh -c '$quote'if [ $last_succ -eq 0 ]; then echo $black; else echo ${red};fi'$quote'`'
set _cs2='`sh -c '$quote'echo ${end};'$quote'`'
set cmd_succ="${_cs1}|${_cs2}"

set pwd_str="${green}[%~]${end}"

set git_head_name="'(`git symbolic-ref HEAD | rev | cut -d'/' -f1 | rev`)'"
set git_str='`sh -c '$quote'if [ -d .git ]; then echo $git_head_name; fi'$quote'`'

set newline="\n"

set time_str="${cyan}%T${end}"
set user_str="${yellow}%n${end}"
set host_str="${white}%m${end}"

set shell_name="`echo $SHELL | rev | cut -d'/' -f1 | rev`"

set uid_str='`sh -c '$quote'if [ $_uid == root ]; then echo \#; else echo \>;fi'$quote'`'

if(! $?WINDOW ) then
        alias precmd 'set last_succ="$?"; set _uid="`whoami`"; set prompt="'${cmd_succ}'${pwd_str}'${git_str}'${blue}jobs:%j${end}%{${newline}%}'${cmd_succ}'${time_str}${user_str}@${host_str}${blue}['${shell_name}']${end}'${uid_str}' "'
    else
        set session_name="`echo $STY | cut -d '.' -f2`"
        set screen_str="${purple}[$session_name W$WINDOW]${end}"
        alias precmd 'set last_succ="$?"; set _uid="`whoami`"; set prompt="'${cmd_succ}'${pwd_str}'${git_str}'${blue}jobs:%j${end}%{${newline}%}'${cmd_succ}'${time_str}${user_str}@${host_str}${blue}['${shell_name}']${end}${screen_str}'${uid_str}' "'
endif

#set prompt="%{^[[1;36m%}%T%{^[[m%}%{^[[1;33m%}%n%{^[[m%}@%{^[[1;37m%}%m%{^[[1;32m%}[%~]%{^[[m%}%{^[[1;35m%}[$session_name W$WINDOW]%{^[[m%}> "

exit

needed info

-   pwd

    -   green

-   if the shell is in a screen, show window name

    -   purple

-   if pwd is in a git repo, show branch name

    -   blue

-   time

    -   cyan

-   username

    -   bright yellow

-   hostname

    -   bright white

    -   // blue if bash

-   uid (root or mortal)

    -   > if mortal

    -   # if root

-   last command status

    -   display on uid symbol

    -   white if success

    -   red if failed


[{pwd}][{window_name} {window_index}]({branch_name})
{time}{username}@{hostname}> {cursor here}
