#!/bin/sh

good_tag="\033[1;32m"
not_sure_tag="\033[1;33m"
error_tag="\033[1;31m"
end_tag="\033[m"

files="zsh/.zshrc
zsh/.zshenv
.vimrc
.screenrc
.tcshrc
.bashrc
.gitconfig"

for f in $files; do

    if [ "${f##*/}" == $f ]; then   # normal file
        filename="$f"
    else                            # this file is in deeper directory
        filename="${f##*/}"
    fi

    printf "Installing $filename into $HOME\n"

    if [ -f "$HOME/$filename" ]; then

        printf "${error_tag}$HOME/$filename exists, do backup${end_tag}\n"

        if [ ! -d "$HOME/.old_rcfiles" ]; then

            printf "${error_tag}$HOME/.old_rcfiles/ directory not exist, create one${end_tag}\n"

            mkdir "$HOME/.old_rcfiles"

            printf "${good_tag}$HOME/.old_rcfiles ready${end_tag}\n"

        fi

        if [ "$BACKUP_DIR" == "" ]; then

            BACKUP_DIR=`date "+%Y%m%d_%H%M%S"`
            printf "${not_sure_tag}Create new backup directory: $HOME/.old_rcfiles/$BACKUP_DIR${end_tag}\n"
            mkdir "$HOME/.old_rcfiles/$BACKUP_DIR"

        fi

        mv "$HOME/$filename" "$HOME/.old_rcfiles/$BACKUP_DIR"

        printf "${good_tag}Backup $HOME/.$filename done${end_tag}\n"
    
    fi

    ln -sf "$HOME/.rcfiles/$f" "$HOME/$filename"
    # if the soft link is targeted to a none-exist file,
    #  the "if [ -f $filename ]" will be false
    #  but the following "ln -s" will failed
    #  so the -f option is needed

    echo "Install $HOME/$filename done"
    echo ""

done

echo "Done"

if [ ! "$BACKUP_DIR" == "" ]; then
    echo "Old configuration files are now in $HOME/.old_rcfiles/$BACKUP_DIR"
fi
