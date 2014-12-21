setlocal commentstring=#%s
setlocal softtabstop=4
setlocal shiftwidth=4

let s:blpattern             = '^ *[-*+] \+\([^ ].*\)\?$'                    " *
let s:elpattern_dot         = '^ *\(\d\+\|#\|[a-zA-Z]\)\. \+\([^ ].*\)\?$'  " 1. | #. | a.
let s:elpattern_parentheses = '^ *(\?\(\d\+\|[a-zA-Z]\)) \+\([^ ].*\)\?$'   " 1) | (2) | a) | (a)

" generate a checkbox at the beginning of line
nnoremap <buffer> <silent> <C-c> :call Add_checkbox()<CR>
inoremap <buffer> <silent> <C-c> <ESC>:call Add_checkbox()<CR>
vnoremap <buffer> <silent> <C-c> :call Add_checkbox()<CR>
function! Add_checkbox ()
    let l:line = getline('.')

    let l:pspace = matchstr(l:line, '^ *')

    if l:line =~# s:blpattern
        let l:text = matchstr(l:line, '\(^ *[-*+] \+\)\@<=[^ ].*$')
    elseif l:line =~# s:elpattern_dot
        let l:text = matchstr(l:line, '\(^ *\(\d\+\|#\|[a-zA-Z]\)\. \+\)\@<=[^ ].*$')
    elseif l:line =~# s:elpattern_parentheses
        let l:text = matchstr(l:line, '\(^ *(\?\(\d\+\|[a-zA-Z]\)) \+\)\@<=[^ ].*$')
    else
        let l:text = l:line[strlen(l:pspace):]
    endif

    if l:text[0:2] == '[ ]'
        let l:text = '[v]' . l:text[3:]

    elseif l:text[0:2] == '[v]'
        let l:text = '[x]' . l:text[3:]

    elseif l:text[0:2] == '[x]'
        let l:text = '[ ]' . l:text[3:]

    elseif l:text[0:2] =~ '^\[.\]$'
        let l:text = '[ ]' . l:text[3:]

    else
        let l:text = '[ ] ' . l:text
    endif

    call setline('.', l:pspace . l:text)
endfunction
