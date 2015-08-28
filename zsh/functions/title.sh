title () {
    case $ZSH_KERNEL_TYPE in
        "CYGWIN")
            printf "\033]0;$@\007"
            ;;
        *)
            printf "\033]1;$@\a"
    esac
}

