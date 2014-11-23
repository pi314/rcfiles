#!/bin/sh

files="zsh/.zshrc
zsh/.zshenv
.vim/
.screenrc
.tcshrc
.bashrc
.gitconfig"

good_color="\033[1;32m"
not_sure_color="\033[1;33m"
error_color="\033[1;31m"
end_color="\033[m"

BACKUP_DIR_NAME="`date +%Y%m%d_%H%M%S`"
BACKUP_FILE_PATH="$HOME/.old_rcfiles/$BACKUP_DIR_NAME"

while [ "n$1" != "n" ]; do
    case $1 in
        "--quiet" | "-q")
            QUIET=1
            ;;

        *)
            echo "Unknown option: $1, ignore"
            ;;

    esac
    shift
done

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
    __return_var=$1

    while [ 1 ]; do
        read ybn
        case $ybn in
            [Yy] | "")
                break;;

            [Bb] )
                break;;

            [Nn] )
                break;;

            * )
                ;;

        esac

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
        while [ 1 ]; do
            read ybn
            case $ybn in
                [Yy] | "" )
                    rm "$HOME/$filename"
                    printf "${good_color}$filepath removed${end_color}\n"
                    break ;;

                [Bb] )
                    backup_old_file "$filepath"
                    printf "${good_color}Backup $filename done${end_color}\n"
                    break;;

                [Nn] )
                    printf "${not_sure_color}Installation of $filename canceled${end_color}\n"
                    INSTALL=0
                    break;;

                * )
                    printf "Please answer yes ,no, or backup. [Y(es) / n(o) / b(ackup)] "
                    ;;
            esac
        done

    elif [ -d "$filepath" ]; then
        printf "${error_color}$filepath/ directory exists, remove it? [Y(es) / n(o) / b(ackup)]${end_color} "
        while [ 1 ]; do
            read ybn
            case $ybn in
                [Yy] | "" )
                    rm -r "$HOME/$filename/"
                    printf "${good_color}$filepath/ removed${end_color}\n"
                    break ;;

                [Bb] )
                    backup_old_file "$filepath"
                    printf "${good_color}Backup $filename done${end_color}\n"
                    break;;

                [Nn] )
                    printf "${not_sure_color}Installation of $filename canceled${end_color}\n"
                    INSTALL=0
                    break;;

                * )
                    printf "Please answer yes ,no, or backup. [Y(es) / n(o) / b(ackup)] "
                    ;;
            esac
        done

    fi

    if [ $INSTALL -eq 1 ]; then
        ln -s "$HOME/.rcfiles/$f" "$HOME/$filename"
        echo "Install $HOME/$filename done"
    fi

    echo ""

done

echo "Installation completed"

if [ -d "$BACKUP_FILE_PATH" ]; then
    echo "Old configuration files are now in $HOME/.old_rcfiles/$BACKUP_DIR"
fi

printf "Do you want to install all vim plugins now? [Y/n] "
while [ 1 ]; do
    read ybn
    case $ybn in
        [Yy] | "" )
            printf "Installing vundle plugin...\n"
            git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
            printf "Done\n"
            printf "Installing other plugin...\n"
            sleep 1
            vim +PluginInstall +qall
            break ;;

        [Nn] )
            echo "vim plugin installation canceled"
            break;;

        * )
            printf "Please answer yes or no. [Y(es) / n(o)] "
            ;;
    esac
done
echo "Vim installation completed"
