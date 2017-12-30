v () {
    # vim +"$($@ | sed 's/^\([^:]\+\):\([0-9]\+\):.*$/tabnew +\2 \1/g; $!a|')"
    if [ -t 0 ] && [ $# -eq 0 ]; then
        vim
    else
        (while [ $# -gt 0 ]; do echo $1; shift; done; if [ ! -t 0 ]; then cat; fi) | vim - \
            +'v/\v^([^:]+):(\d+):.*$/normal! A:1:' \
            +'%s/\v^([^:]+):(\d+):.*$/tabnew +\2 \1 \|/g' \
            +'%s/\n//g' \
            +'normal $xx' \
            +'execute getline(".")' \
            +'tabn 1' \
            +'q!' \
            +"noh"
    fi
}
