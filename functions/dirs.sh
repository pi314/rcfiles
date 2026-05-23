dirs () {
    builtin dirs -p -v | sed 's/\t/ │ /' | tac
}
