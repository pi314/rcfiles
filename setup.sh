#!/bin/sh

files="zsh/.zshrc
zsh/.zshenv
.vim/
.screenrc
.tcshrc
.bashrc
.bash_profile
.gitconfig
.tmux.conf"

good_color="\033[1;32m"
not_sure_color="\033[1;33m"
error_color="\033[1;31m"
end_color="\033[m"

BACKUP_DIR_NAME="`date +%Y%m%d_%H%M%S`"
BACKUP_FILE_PATH="$HOME/.old_rcfiles/$BACKUP_DIR_NAME"

get_file_name () {
    f=$1
    if [ "${f##*/}" = $f ]; then   # normal position
        echo "$f"
    elif [ "n${f##*/}" = "n" ]; then   # the "file" is a directory
        # this is important: return ".vim" instead of ".vim/"
        # or your "$HOME/.vim" LINK will considered to be a directory
        echo "${f%%/*}"
    else                            # this file is in deeper directory
        echo "${f##*/}"
    fi
}

backup_old_file () {

    if [ ! -d "$HOME/.old_rcfiles" ]; then
        printf "${error_color}$HOME/.old_rcfiles/ directory not exist, create one${end_color}\n"
        mkdir "$HOME/.old_rcfiles"
        printf "${good_color}$HOME/.old_rcfiles/ ready${end_color}\n"

    fi

    if [ ! -d "$BACKUP_FILE_PATH" ]; then
        printf "${not_sure_color}Create new backup directory: $BACKUP_FILE_PATH${end_color}/\n"
        mkdir "$BACKUP_FILE_PATH"

    fi

    mv "$1" "$BACKUP_FILE_PATH"
}

ask_user () {
    # usage: ask_user [Options] [error_msg]
    # first option character will be the default option
    options=$(echo $1 | tr '[:upper:]' '[:lower:]')
    error_msg=$2
    ret=""

    while [ 1 ]; do
        read user_input
        user_input=$(echo $user_input | tr '[:upper:]' '[:lower:]')
        if [ "=$user_input" = "=" ]; then
            # user input empty string (an newline char), use the default option
            ret=${options:0:1}

        else
            # user input something, check it out
            for i in $(echo $options | grep -o .); do
                if [ "=$i" = "=$user_input" ]; then
                    ret=$i
                    break
                fi
            done

        fi

        if [ -z $ret ]; then
            # user input didn't match anything, reject!
            printf "$error_msg" 1>&2
        else
            echo $ret
            break
        fi

    done

}

for f in $files; do

    filename=`get_file_name $f`
    filepath="$HOME/$filename"
    printf "Installing $filename into $HOME\n"

    INSTALL=1

    if [ -L "$filepath" ]; then
        rm "$filepath"
        printf "${not_sure_color}$filepath@ symbolic link removed${end_color}\n"

    elif [ -f "$filepath" ]; then
        printf "${error_color}$filepath file exists, remove it? [Y(es) / n(o) / b(ackup)]${end_color} "
        answer=$(ask_user ybn "${error_color}Please answer yes ,no, or backup. [Y(es) / n(o) / b(ackup)]${end_color} ")

        case $answer in
            [Yy] )
                rm "$HOME/$filename"
                printf "${good_color}$filepath removed${end_color}\n"
                ;;

            [Bb] )
                backup_old_file "$filepath"
                printf "${good_color}Backup $filename done${end_color}\n"
                ;;

            [Nn] )
                printf "${not_sure_color}Installation of $filename canceled${end_color}\n"
                INSTALL=0
                ;;

        esac

    elif [ -d "$filepath" ]; then
        printf "${error_color}$filepath/ directory exists, remove it? [Y(es) / n(o) / b(ackup)]${end_color} "
        answer=$(ask_user ybn "${error_color}Please answer yes ,no, or backup. [Y(es) / n(o) / b(ackup)]${end_color} ")
        case $answer in
            [Yy] | "" )
                rm -r "$HOME/$filename/"
                printf "${good_color}$filepath/ removed${end_color}\n"
                ;;

            [Bb] )
                backup_old_file "$filepath"
                printf "${good_color}Backup $filename done${end_color}\n"
                ;;

            [Nn] )
                printf "${not_sure_color}Installation of $filename canceled${end_color}\n"
                INSTALL=0
                ;;

        esac

    fi

    if [ $INSTALL -eq 1 ]; then
        ln -s "$HOME/.rcfiles/$f" "$HOME/$filename"
        printf "${good_color}Install $HOME/$filename done${end_color}\n"
    fi

    echo ""

done

echo "Installation completed"

if [ -d "$BACKUP_FILE_PATH" ]; then
    echo "Old configuration files are now in $HOME/.old_rcfiles/$BACKUP_DIR"
fi

if [ -n "$(command -v git)" ] && [ -n "$(command -v vim)" ]; then
    printf "Do you want to install all vim plugins now? [Y/n] "
    answer=$(ask_user yn "${error_color}Please answer yes or no. [Y(es) / n(o)]${end_color} ")

    case $answer in
        [Yy] )
            printf "Installing vundle plugin...\n"
            if [ ! ~/.vim/bundle/Vundle.vim ]; then
                git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
            fi
            printf "Done\n"
            printf "Installing other plugin...\n"
            sleep 1
            vim +PluginInstall +qall
            printf "${good_color}vim plugin installation completed${end_color}\n"
            printf "Updating...\n"
            vim +PluginUpdate +qall
            printf "${good_color}vim plugin update completed${end_color}\n"
            ;;

        [Nn] )
            echo "vim plugin installation canceled"
            ;;

    esac

else
    printf "${error_color}git or vim does not exist, vim plugin installation canceled${end_color}"

fi

