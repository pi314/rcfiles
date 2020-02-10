#!/usr/bin/env sh

pack () {
    # pack -h
    # pack [-c] archive-file source-file ...

    if [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
        pack_help
        return 1
    fi

    # setup 'clean' bit
    if [ "$1" = '-c' ] || [ "$1" = '--clean' ]; then
        clean=1
        shift
    else
        clean=0
    fi

    if [ $# -le 1 ]; then
        pack_help
        unset clean
        return 1
    fi

    afile="$1"
    shift

    # check if the archive file already exists
    if [ -f "$afile" ] || [ -d "$afile" ]; then
        echo "File \"$afile\" already exists"
        unset afile
        unset clean
        return 1
    fi

    # format check based on the file extension
    case "$afile" in
        -)          afile='-'; format='tar' ;;
        *.tar)      format='tar' ;;
        *.tar.bz)   afile="${afile%*.tar.bz}.tar.bz2" ; format='tar.bz2' ;;
        *.tbz)      afile="${afile%*.tar.bz}.tbz2" ;    format='tar.bz2' ;;
        *.tar.bz2)  format='tar.bz2' ;;
        *.tbz2)     format='tar.bz2' ;;
        *.tar.gz)   format='tar.gz' ;;
        *.tgz)      format='tar.gz' ;;
        *.tar.xz)   afile="${afile%*.tar.xz}.tar" ;     format='tar.xz' ;;
        *.xz)       afile="${afile%*.xz}.tar" ;         format='tar.xz' ;;
        *.tar.Z)    afile="${afile%*.tar.Z}.tar" ;      format='tar.Z' ;;
        *.Z)        afile="${afile%*.Z}.tar" ;          format='tar.Z' ;;
        *.bz)       afile="${afile%*.bz}.tar.bz2" ;     format='tar.bz2' ;;
        *.bz2)      afile="${afile%*.bz2}.tar.bz2" ;    format='tar.bz2' ;;
        *.gz)       afile="${afile%*.gz}.tar.gz" ;      format='tar.gz' ;;
        *.zip)      format='zip' ;;
        *.7z)       format='7z' ;;
        *)
            echo "Don't know how to pack \"$afile\""
            unset afile
            unset format
            unset clean
            return 1
            ;;
    esac

    # check if target is stdout
    case "$afile" in
        -.*)    afile='-' ;;
    esac

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

    # "7z" format streaming is not supported
    if [ "$format" = '7z' ] && [ "$afile" = '-' ]; then
        echo '"7z" format streaming is not supported'
        unset afile
        unset format
        unset clean
        return 1
    fi

    # packing
    case "$format" in
        tar)        tar cvf  "$afile" --exclude "$afile" "$@" ;;
        tar.bz2)    tar jcvf "$afile" --exclude "$afile" "$@" ;;
        tar.gz)     tar zcvf "$afile" --exclude "$afile" "$@" ;;
        tar.xz)
            if [ "$afile" = '-' ]; then
                tar cvf - --exclude "$afile" "$@" | xz --stdout
            else
                # ``xz`` automatically removes the original file
                tar cvf "$afile" --exclude "$afile" "$@" && xz "$afile"
            fi
            ;;
        tar.Z)
            # ``compress`` automatically removes the original file
            if [ "$afile" = '-' ]; then
                tar cvf "$afile" "$@" | compress -c -
            else
                tar cvf "$afile" --exclude "$afile" "$@" && compress -f "$afile"
            fi
            ;;
        zip)    zip --symlinks --exclude "$afile" -r "$afile" "$@" ;;
        7z)     7z a "$afile" "$@" ;;
    esac

    ret_code=$?

    # check if packing succeed
    if [ ${ret_code} -ne 0 ]; then
        unset afile
        unset format
        unset clean
        return 1
    fi

    # clean up source files if clean bit is set
    if [ ${ret_code} -eq 0 ] && [ "$clean" -eq 1 ]; then
        while [ $# -gt 0 ]; do
            if [ "$1" != "$afile" ]; then
                rm -r "$1"
            fi
            shift
        done
    fi

    unset afile
    unset format
    unset clean
    return 0
}


pack_help () {
    echo 'Usage:'
    echo '  pack -h'
    echo '  pack [-c] archive-file source-file'
    echo ''
    echo 'Optional arguments:'
    echo ''
    echo '  -h, --help      Show this help message and exit'
    echo '  -c, --clean     Remove source files after packed'
    echo ''
    echo 'Supported formats:'
    echo '  *.tar'
    echo '  *.tar.bz, *.tar.bz2, *.tbz, *.tbz2'
    echo '  *.tar.gz, *.tgz'

    if command -v xz >/dev/null 2>&1; then
        echo '  *.tar.xz'
    else
        echo '  *.tar.xz    - (not available: xz)'
    fi

    if command -v compress >/dev/null 2>&1; then
        echo '  *.tar.Z'
    else
        echo '  *.tar.Z     - (not available: compress)'
    fi

    if command -v zip >/dev/null 2>&1; then
        echo '  *.zip'
    else
        echo '  *.zip       - (not available: zip)'
    fi

    if command -v 7z >/dev/null 2>&1; then
        echo '  *.7z'
    else
        echo '  *.7z        - (not available: zip)'
    fi
}


pack "$@"
