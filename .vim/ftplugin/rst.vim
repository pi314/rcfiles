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
function! Title(title_char)
    if len(a:title_char) == 1
        let current_line_content = getline('.')

        if l:current_line_content =~# '^\([^a-zA-Z]\)\1*$'  " the cursor is on the title line?
            call cursor(line('.') - 1, col('.'))
        endif

        let title_string = repeat(a:title_char, strdisplaywidth(l:current_line_content))
        let next_line_content = getline(line('.') + 1)

        if l:next_line_content ==# ''
            call append('.', l:title_string)

        elseif l:next_line_content =~# '^\([^a-zA-Z]\)\1*$'
            call setline(line('.')+1, l:title_string)

        else
            call append('.', '')
            call append('.', l:title_string)

        endif

    endif

endfunction

nnoremap < <<
nnoremap > >>
