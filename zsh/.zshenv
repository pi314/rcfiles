if [[ -f /etc/profile ]]; then
    backup_PATH=$PATH
    PATH=""
    source /etc/profile

    if [[ -z $PATH ]]; then
        # /etc/profile is empty
        PATH=$backup_PATH
    fi
fi

folders=(
    "/opt/local/bin"
    "/opt/local/sbin"
    "/opt/local/share/java/android-sdk-macosx/platform-tools"
    "/opt/local/Library/Frameworks/Python.framework/Versions/3.5/bin"
    "$HOME/.cabal/bin"
    "$HOME/bin"
)

for i in $folders; do
    if [[ -d $i ]]; then
        if [[ $PATH != *$i* ]]; then
            PATH="$i:$PATH"
        fi
    fi
done

export PATH

export ZSH_KERNEL_TYPE="$(/usr/bin/env uname -s)"

case $ZSH_KERNEL_TYPE in

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
        if [[ "$ZSH_KERNEL_TYPE" == "CYGWIN"* ]]; then
            export ZSH_KERNEL_TYPE="CYGWIN"
            export LS_VERSION="GNU"
        else
            export ZSH_KERNEL_TYPE="UNKNOWN"
            echo "Unknown OS type"
            uname -a
            export LS_VERSION="GNU"     # guess it uses GNU ls
        fi

esac

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
export LSCOLORS='GxFxcxDxCxegedabagacad'

# di: directories
# ln: symbolic links
# pi:
export LS_COLORS="di=01;36:ln=01;35:pi=01;33:ex=01;32"

export EDITOR=vim
export PAGER=less

encode=zh_TW.UTF-8
export LANG=$encode
export LANGUAGE=$encode
export LC_CTYPE=$encode
export LC_NUMERIC=$encode
export LC_TIME=$encode
export LC_COLLATE=$encode
export LC_MONETARY=$encode
export LC_MESSAGES=$encode
export LC_ALL=$encode

