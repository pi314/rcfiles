_get_parent_folders () {
    local pwd_str="$(pwd)"
    local climber="$(dirname $pwd_str)"
    local indicator="../"
    while [ "$climber" != "/" ]; do
        echo "${indicator}:\"${climber}\" "
        climber="$(dirname $climber)"
        indicator="${indicator}../"
    done
    echo "${indicator}:\"${climber}\""
}

up () {
    if [[ $# -eq 0 ]]; then
        cd ..
    else
        cd $1
    fi
}
