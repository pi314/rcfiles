setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal wrap

" Add a line under a rst title
nnoremap <buffer> <silent> t0 :call Title("=")<CR>jyykP
nnoremap <buffer> <silent> t1 :call Title("=")<CR>
nnoremap <buffer> <silent> t2 :call Title("-")<CR>
nnoremap <buffer> <silent> t3 :call Title("~")<CR>
nnoremap <buffer> <silent> t4 :call Title('"')<CR>
nnoremap <buffer> <silent> t5 :call Title("'")<CR>
nnoremap <buffer> <silent> t6 :call Title("`")<CR>

function! Title(title_char)
    if len(a:title_char) == 1
        let line = getline('.')

        let title_pattern = '^\([^a-zA-Z]\)\1*$'
        if l:line =~# l:title_pattern
            " the cursor is on the title line
            call cursor(line('.') - 1, col('.'))
        endif

        let title_string = repeat(a:title_char, strdisplaywidth(l:line))
        let next_line_content = getline(line('.') + 1)

        if l:next_line_content ==# ''
            call append('.', l:title_string)

        elseif l:next_line_content =~# l:title_pattern
            call setline(line('.')+1, l:title_string)

        else
            call append('.', '')
            call append('.', l:title_string)

        endif

    endif

endfunction

nnoremap <buffer> <silent> < :call ShiftIndent("LEFT")<CR>
nnoremap <buffer> <silent> > :call ShiftIndent("RIGHT")<CR>
vnoremap <buffer> <silent> < :call ShiftIndent("LEFT")<CR>
vnoremap <buffer> <silent> > :call ShiftIndent("RIGHT")<CR>

function! ShiftIndent (direction)
    let line = getline('.')
    let pspace = strlen(matchstr(l:line, '^ *'))
    let line_after_space  = l:line[ (l:pspace) :]
    let remain_space = l:pspace % (&shiftwidth)

    if a:direction ==# "LEFT"
        let pspace = l:pspace - ((l:remain_space != 0) ? (l:remain_space) : &shiftwidth)
        let l:pspace = (l:pspace < 0) ? 0 : (l:pspace)

    else
        let pspace = l:pspace + ((l:remain_space != 0) ? (&shiftwidth - l:remain_space) : &shiftwidth)

    endif

    if l:line_after_space =~# '^[-*+] \+.*$'
        " bulleted list
        let bullet = "*-+"[(l:pspace / &shiftwidth) % 3]
        let pure_data = matchstr(l:line_after_space[1:], '\(^ \+\)\@<=[^ ].*$')
        let bullet_space = repeat(' ', &softtabstop - ((l:pspace + 1) % (&softtabstop)) )
        let line_after_space = l:bullet . l:bullet_space . l:pure_data

    endif

    call setline('.', repeat(' ', l:pspace) . l:line_after_space)
    normal! ^

endfunction
