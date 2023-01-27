if [ -n "$(command -v fd)" ]; then
    true

elif [ -n "$(command -v ag)" ]; then
    fd () {
        if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
            echo '$ ag -g "$1"'
            return 1
        fi

        ag -g "$1"
    }

else
    fd () {
        if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
            echo '$ find . | grep "$1"'
            return 1
        fi

        find . | grep "$1"
    }

fi
