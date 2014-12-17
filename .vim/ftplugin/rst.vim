setlocal softtabstop=2
setlocal shiftwidth=2

" Add a line under a rst title
nnoremap <buffer> <silent> t0 :call Title("==")<CR>
nnoremap <buffer> <silent> t1 :call Title("=")<CR>
nnoremap <buffer> <silent> t2 :call Title("-")<CR>
nnoremap <buffer> <silent> t3 :call Title("~")<CR>
nnoremap <buffer> <silent> t4 :call Title('"')<CR>
nnoremap <buffer> <silent> t5 :call Title("'")<CR>
nnoremap <buffer> <silent> t6 :call Title("`")<CR>

function! Title(i_title_char) " {{{
    let title_char = a:i_title_char
    let t0 = 0

    if l:title_char ==# "=="
        let t0 = 1
        let l:title_char = "="

    elseif len(l:title_char) != 1
        return

    endif

    let orig_row = line('.')
    let orig_col = col('.')
    let line = getline('.')

    let title_pattern = '^\([^a-zA-Z]\)\1*$'
    if l:line =~# l:title_pattern
        " the cursor is on the title line
        if getline(l:orig_row + 2) =~# l:title_pattern
            " the cursor is on the t0 upper line
            call cursor(l:orig_row + 1, col('.'))

        else
            " the cursor is on the t0 lower line
            call cursor(l:orig_row - 1, col('.'))

        endif

    endif

    if getline(line('.') - 1) =~# l:title_pattern
        " remove the t0 upper line
        normal! kdd
        call cursor(line('.'), l:orig_col)
    endif

    let title_string = repeat(l:title_char, strdisplaywidth(l:line))
    let next_line_content = getline(line('.') + 1)

    if l:next_line_content ==# ''
        call append('.', l:title_string)

    elseif l:next_line_content =~# l:title_pattern
        call setline(line('.')+1, l:title_string)

    else
        call append('.', '')
        call append('.', l:title_string)

    endif

    if l:t0
        call append(line('.') - 1, l:title_string)
    else
        call cursor(l:orig_row, col('.'))
    endif

endfunction " }}}

nnoremap <buffer> <silent> < :call ShiftIndent("LEFT")<CR>
nnoremap <buffer> <silent> > :call ShiftIndent("RIGHT")<CR>
vnoremap <buffer> <silent> < :call ShiftIndent("LEFT")<CR>gv
vnoremap <buffer> <silent> > :call ShiftIndent("RIGHT")<CR>gv

function! ShiftIndent (direction) " {{{
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

    call setline('.', RefreshListSign(repeat(' ', l:pspace) . l:line_after_space) )
    normal! ^

endfunction " }}}

function! RefreshListSign (line) " {{{
    let ret = a:line
    if a:line =~# '^ *[-*+] \+.*$'
        " bulleted list
        let pspace = strlen(matchstr(a:line, '^ *'))
        let text   = matchstr( a:line[(l:pspace + 1):], '\(^ \+\)\@<=[^ ].*$')
        let bullet_space = repeat(' ', &softtabstop - ((l:pspace + 1) % (&softtabstop)) )
        let bullet = "*-+"[(l:pspace / &shiftwidth) % 3]
        let ret = repeat(' ', l:pspace) . l:bullet . l:bullet_space . l:text
    endif
    return l:ret
endfunction " }}}

inoremap <buffer> <silent> <leader>b <ESC>:call CreateBullet()<CR>a
function! CreateBullet () " {{{
    let cln = line('.')
    let clc = getline(l:cln)

    if l:clc =~# '^ *[-*+] \+.*$'
        call setline(l:cln, RefreshListSign(l:clc))

    elseif l:clc =~# '^ *$'
        if l:cln > 1
            let llc = getline(l:cln - 1)
        endif

        if l:cln > 1 && l:llc =~# '^ *[-*+] \+.*$'
            let pspace = strlen(matchstr(l:llc, '^ *'))
            call setline(l:cln, RefreshListSign(repeat(' ', l:pspace) .'- '))
            call cursor(l:cln, strlen(getline(l:cln)) + 2)

        else
            let pspace = strlen(l:clc)
            call setline(l:cln, RefreshListSign(repeat(' ', l:pspace) .'- '))
            call cursor(l:cln, strlen(getline(l:cln)) + 2)

        endif

    else
        let pspace = strlen(matchstr(l:clc, '^ *'))
        let text = matchstr(l:clc, '\(^ *\)\@<=.*$')
        let back_space = (l:pspace) % (&softtabstop)
        call setline(l:cln, RefreshListSign(repeat(' ', l:pspace - l:back_space) .'- '. l:text))
        call cursor(l:cln, strlen(getline(l:cln)) + 2)

    endif

endfunction " }}}
