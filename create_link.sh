#!/bin/sh

set -- `getopt f,: $@`

flags="s"
force_replace=0

while [ $# -gt 0 ]; do
    case "$1" in
        -f) force_replace=1;;
    esac
    shift
done

if [ $force_replace -eq 1 ]; then
    flags=${flags}f
fi

ln -${flags} ~/.rcfiles/.tcshrc    ~/.tcshrc
ln -${flags} ~/.rcfiles/.vimrc     ~/.vimrc
ln -${flags} ~/.rcfiles/.screenrc  ~/.screenrc
ln -${flags} ~/.rcfiles/.bashrc    ~/.bashrc
ln -${flags} ~/.rcfiles/.gitconfig ~/.gitconfig
