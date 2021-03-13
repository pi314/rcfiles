#!/usr/bin/env sh


unpack () {
    # unpack -h
    # unpack [-c] archive-file

    if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
        unpack_help
        return 1
    fi

    # setup 'clean' bit
    if [ "$1" = '-d' ] || [ "$1" = '--delete' ]; then
        clean=1
        shift
    else
        clean=0
    fi

    if [ $# -lt 1 ]; then
        unpack_help
        unset clean
        return 1
    fi

    if [ $# -gt 1 ]; then
        while [ $# -gt 0 ]; do
            unpack "$1"
            shift
        done
        return
    fi

    afile="$1"
    shift

    # format check based on the file extension
    case "$afile" in
        -)          afile='-'; format='tar' ;;
        *.tar)      format='tar' ;;
        *.tar.bz)   format='tar.bz2' ;;
        *.tar.bz2)  format='tar.bz2' ;;
        *.tbz)      format='tar.bz2' ;;
        *.tbz2)     format='tar.bz2' ;;
        *.tar.gz)   format='tar.gz' ;;
        *.tgz)      format='tar.gz' ;;
        *.tar.xz)   format='tar.xz' ;;
        *.xz)       format='xz' ;;
        *.tar.Z)    format='tar.Z' ;;
        *.Z)        format='Z' ;;
        *.bz)       format='bz2' ;;
        *.bz2)      format='bz2' ;;
        *.gz)       format='gz' ;;
        *.zip)      format='zip' ;;
        *.7z)       format='7z' ;;
        *.rar)      format='rar' ;;
        *.jar)      format='tar' ;;
        *)
            echo "Don't know how to unpack \"$afile\""
            unset afile
            unset format
            unset clean
            return 1
            ;;
    esac

    # check if source is stdout
    case "$afile" in
        -.*)    afile='-' ;;
    esac

    # check if the archive file exists
    if [ ! -f "$afile" ] && [ "$afile" != '-' ]; then
        echo "File \"$afile\" does not exist"
        unset afile
        unset clean
        return 1
    fi

    # need "zip", check if "zip" installed
    if [ "$format" = 'zip' ] && ! command -v zip >/dev/null 2>&1; then
        echo 'The "zip" utility is not installed'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # need "7z", check if "7z" installed
    if [ "$format" = '7z' ] && ! command -v 7z >/dev/null 2>&1; then
        echo 'The "7z" utility is not installed'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # need "unrar", check if "unrar" installed
    if [ "$format" = 'rar' ] && ! command -v unrar >/dev/null 2>&1; then
        echo 'The "unrar" utility is not installed'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # "zip" format streaming is not supported
    if [ "$format" = 'zip' ] && [ "$afile" = '-' ]; then
        echo '"zip" format streaming is not supported'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # "7z" format streaming is not supported
    if [ "$format" = '7z' ] && [ "$afile" = '-' ]; then
        echo '"7z" format streaming is not supported'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # unpacking
    case "$format" in
        tar)        tar xvf  "$afile" ;;
        tar.bz2)    tar jxvf "$afile" ;;
        tar.gz)     tar zxvf "$afile" ;;
        tar.xz)
            if [ "$afile" = '-' ]; then
                unxz - | tar xvf -
            else
                unxz "$afile" && tar xvf ${afile%*.xz}
            fi
            ;;
        tar.Z)
            if [ "$afile" = '-' ]; then
                uncompress - | tar xvf -
            else
                uncompress "$afile" && tar xvf ${afile%*.Z}
            fi
            ;;
        xz)
            if [ "$afile" = '-' ]; then
                unxz -
            else
                unxz "$afile"
            fi
            ;;
        Z)
            if [ "$afile" = '-' ]; then
                uncompress -
            else
                uncompress "$afile"
            fi
            ;;
        gz)     gzip -d "$afile" ;;
        bz2)    bunzip2 "$afile" ;;
        zip)    unzip "$afile" ;;
        7z)     7z x "$afile" ;;
        rar)    unrar x "$afile" ;;
    esac

    ret_code=$?

    # check if packing succeed
    if [ ${ret_code} -ne 0 ]; then
        unset afile
        unset format
        unset clean
        return 1
    fi

    # clean up source file if clean bit is set
    if [ ${ret_code} -eq 0 ] && [ "$clean" -eq 1 ]; then
        rm -r "$afile"
    fi

    unset afile
    unset format
    unset clean
    return 0
}


unpack_help () {
    echo 'Usage:'
    echo '  unpack -h'
    echo '  unpack [-d] archive-file'
    echo ''
    echo 'Optional arguments:'
    echo ''
    echo '  -h, --help      Show this help message and exit'
    echo '  -d, --delete    Remove archive file after unpacked'
    echo ''
    echo 'Supported formats:'
    echo '  *.tar'
    echo '  *.tar.bz, *.tar.bz2, *.tbz, *.tbz2'
    echo '  *.tar.gz, *.tgz'
    echo '  *.jar'

    if command -v unxz >/dev/null 2>&1; then
        echo '  *.tar.xz'
        echo '  *.xz'
    else
        echo '  *.tar.xz    - (not available: unxz)'
        echo '  *.xz        - (not available: unxz)'
    fi

    if command -v uncompress >/dev/null 2>&1; then
        echo '  *.tar.Z'
        echo '  *.Z'
    else
        echo '  *.tar.Z     - (not available: uncompress)'
        echo '  *.Z         - (not available: uncompress)'
    fi

    if command -v bunzip2 >/dev/null 2>&1; then
        echo '  *.bz, *.bz2'
    else
        echo '  *.bz, *.bz2 - (not available: bunzip2)'
    fi

    if command -v gzip >/dev/null 2>&1; then
        echo '  *.gz'
    else
        echo '  *.gz        - (not available: gzip)'
    fi

    if command -v unzip >/dev/null 2>&1; then
        echo '  *.zip'
    else
        echo '  *.zip       - (not available: unzip)'
    fi

    if command -v 7z >/dev/null 2>&1; then
        echo '  *.7z'
    else
        echo '  *.7z        - (not available: 7z)'
    fi

    if command -v unrar >/dev/null 2>&1; then
        echo '  *.rar'
    else
        echo '  *.rar       - (not available: unrar)'
    fi
}


unpack "$@"
