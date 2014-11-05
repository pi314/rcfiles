setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal wrap

" Add a line under a rst title
nnoremap t1 :Title<SPACE>=<CR>
nnoremap t2 :Title<SPACE>-<CR>
nnoremap t3 :Title<SPACE>~<CR>
nnoremap t4 :Title<SPACE>"<CR>
nnoremap t5 :Title<SPACE>'<CR>
nnoremap t6 :Title<SPACE>`<CR>

command! -nargs=1 Title call Title(<f-args>)
function! Title(type)
    if len(a:type) == 1
        execute "normal yyp$r" . a:type
    else
        echom "Title type must be only one charactor"
    endif
endfunction

