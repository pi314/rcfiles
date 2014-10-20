source liu3.test.vim

function! SendKey (findstart, base)
    if a:findstart
        " locate the start of the boshiamy key sequence
        let line = getline('.')
        let start = col('.') - 1
        while l:start > 0 && l:line[l:start-1] =~# '[,.abcdefghijklmnopqrstuvwxyz1234567890]'
            let start -= 1

        endwhile
        return l:start

    else
        " input key sequence is a:base
        if g:boshiamy_active && has_key(g:boshiamy_table, a:base)
            return g:boshiamy_table[a:base]

        else
            return [a:base." "]

        endif

    endif

endfunction

set completefunc=SendKey

let boshiamy_active = 0
function! Toggle_im ()
    if g:boshiamy_active
        let g:boshiamy_active = 0

    else
        let g:boshiamy_active = 1

    endif
    return ''
endfunction

function! SendSpace ()
    if g:boshiamy_active
        normal i<C-x><C-u>
        return ''

    else
        return ' '

    endif
endfunction

inoremap <expr> ,, Toggle_im()
inoremap <expr> <space> g:boshiamy_active ? "<C-x><C-u>" : " "
autocmd InsertLeave * let g:boshiamy_active=0
