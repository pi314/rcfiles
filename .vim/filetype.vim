if !exists('myfiletype_autocmd_loaded')
    let myfiletype_autocmd_loaded = 1
    au BufNewFile,BufRead *.agda       setf agda
    au BufNewFile,BufRead *.html,*.htm setf htmldjango
    au BufNewFile,BufRead *.make       setf make
    au BufNewFile,BufRead *.rst        setf rst
    au BufNewFile,BufRead *.todo       setf todo
    au BufNewFile,BufRead *.xml        setf xml
    au BufNewFile,BufRead /etc/*       setlocal ts=8
    au BufNewFile,BufRead /var/tmp/*   setlocal ts=8
    au BufNewFile,BufRead .tmux.conf   setf tmux
endif
