pack () {
    # $ pack [-c] target-file source-file ...
    local filename="$1"
    local clean="0"
    local fallback=""
    local flag=""
    local util=""
    if [ $# -lt 1 ]; then
        echo "Usage:"
        echo "    pack [-c] target-file source-file ..."
        return 1
    fi
    shift
    if [ "$filename" = "-c" ]; then
        filename="$1"
        clean="1"
        if [ $# -lt 1 ]; then
            echo "Usage:"
            echo "    pack [-c] target-file source-file ..."
            return 1
        fi
        shift
    fi
    case "$filename" in
        *.tar)      tar  cvf "$filename" --exclude "$filename" $@ ;;
        *.tar.bz2)  tar jcvf "$filename" --exclude "$filename" $@ ;;
        *.tbz2)     tar jcvf "$filename" --exclude "$filename" $@ ;;
        *.tbz)      tar jcvf "$filename" --exclude "$filename" $@ ;;
        *.tar.gz)   tar zcvf "$filename" --exclude "$filename" $@ ;;
        *.tgz)      tar zcvf "$filename" --exclude "$filename" $@ ;;
        *.xz)   fallback="${filename%*.xz}.tar" ;       util="xz" ;;
        *.Z)    fallback="${filename%*.Z}.tar" ;        util="compress" ;;
        *.bz)   fallback="${filename%*.bz}.tar.bz2" ;   flag="j" ;;
        *.bz2)  fallback="${filename%*.bz2}.tar.bz2" ;  flag="j" ;;
        *.gz)   fallback="${filename%*.gz}.tar.gz" ;    flag="z" ;;
        *.zip) zip --symlinks --exclude "$filename" -r "$filename" $@ ;;
        *.7z)  7z a "$filename" $@ ;;
        -) tar jcvf - $@ ;;
        *) echo "Don't know how to pack $filename" ;;
    esac

    if [ "x$flag" != "x" ]; then
        tar ${flag}cvf "$fallback" --exclude "$fallback" $@
    elif [ "x$util" != "x" ]; then
        tar cvf "$fallback" --exclude "$fallback" $@
        $util "$fallback"
    fi

    if [ $? -eq 0 ] && [ "$clean" = "1" ] ; then
        while [ $# -gt 0 ]; do
            if [ $1 != "$filename" ]; then
                rm -r $1
            fi
            shift
        done
    fi
}

unpack () {
    # $ unpack [-c] target-file ...
    local clean="0"
    if [ "$1" = "-c" ]; then
        clean="1"
        shift
    fi
    while [ $# -gt 0 ]; do
        local filename=$1
        if [ "$filename-" = "--" ]; then
            tar xvf -
        elif [ -f "$filename" ]; then
            case $filename in
                *.tar)      tar     xvf     "$filename" ;;
                *.tar.bz2)  tar     xvf     "$filename" ;;
                *.tbz2)     tar     xvf     "$filename" ;;
                *.tbz)      tar     xvf     "$filename" ;;
                *.tar.gz)   tar     xvf     "$filename" ;;
                *.tar.xz)   tar     xvf     "$filename" ;;
                *.tar.Z)    tar     xvf     "$filename" ;;
                *.tgz)      tar     xvf     "$filename" ;;
                *.bz2)      bzip2   -dkv    "$filename" ;;
                *.bz)       bzip2   -dkv    "$filename" ;;
                *.zip)      unzip           "$filename" ;;
                *.gz)       gzip    -dkv    "$filename" ;;
                *.7z)       7z      x       "$filename" ;;
                *.xz)       unxz    -kv     "$filename" ;;
                *.rar)      unrar   x       "$filename" ;;
                *.Z)        uncompress      "$filename" ;;
                *) echo "Don't know how to unpack $filename" >&2 ;;
            esac
            if [ "$clean" = "1" ]; then
                rm -f $filename
            fi
        else
            echo "$filename is not a file." >&2
        fi
        shift
    done
}

