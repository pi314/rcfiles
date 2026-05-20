dirs () {
    builtin dirs | tr ' ' '\n' | tac
}
