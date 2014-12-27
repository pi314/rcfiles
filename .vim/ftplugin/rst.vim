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

let s:blpattern = '^ *[-*+] \+\([^ ].*\)\?$'
let s:elpattern1 = '^ *\d\+\. \+\([^ ].*\)\?$'          " 1.
let s:elpattern2 = '^ *#\. \+\([^ ].*\)\?$'             " #.
let s:elpattern3 = '^ *[a-zA-Z]\. \+\([^ ].*\)\?$'      " a.    A.
let s:elpattern4 = '^ *(\?\d\+) \+\([^ ].*\)\?$'        " 1)    (2)
let s:elpattern5 = '^ *(\?[a-zA-Z]) \+\([^ ].*\)\?$'    " a)    (A)

function! GetLastReferenceLine (cln, pspace_num) " {{{
    if a:cln > 1
        let tmp = ParseBullet(getline(a:cln - 1))
        let llc_pspace = l:tmp['pspace']
        let llc_bullet = l:tmp['bullet']
        let llc_text   = l:tmp['text']
        if l:llc_text == '' && l:llc_bullet == '' && a:cln > 2
            let tmp = ParseBullet(getline(a:cln - 2))
            let llc_pspace = l:tmp['pspace']
            let llc_bullet = l:tmp['bullet']
            let llc_text   = l:tmp['text']
            if l:llc_bullet != '' && strlen(l:llc_pspace) != a:pspace_num && a:pspace_num > 0
                let llc_bullet = ''
                let llc_pspace = ''
            endif

        elseif l:llc_bullet != '' && strlen(l:llc_pspace) != a:pspace_num && a:pspace_num > 0
            let llc_bullet = ''
            let llc_pspace = ''

        endif

    else
        let l:llc_bullet = ''
        let llc_pspace = ''

    endif

    return {'bullet': l:llc_bullet, 'pspace': l:llc_pspace}

endfunction " }}}

function! GetBulletLeader (bullet, pspace_num) " {{{
    if a:bullet =~# '^[-*+]$'
        return "*-+"[(a:pspace_num / &shiftwidth) % 3]
    endif

    let is_enumerate_list_item = 0

    if a:bullet == '#.'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^\d\+\.$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^[a-z]\.$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^[A-Z]\.$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^\d\+)$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^(\d\+)$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^[a-z])$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^[A-Z])$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^([a-z])$'
        let is_enumerate_list_item = 1

    elseif a:bullet =~# '^([A-Z])$'
        let is_enumerate_list_item = 1

    endif

    if l:is_enumerate_list_item
        return ['1.', 'A.', 'a.', '1)', 'A)', 'a)', '(1)', '(A)', '(a)'][(a:pspace_num / &shiftwidth) % 9]
    endif

    return ''
endfunction " }}}

function! ShiftIndent (direction) " {{{
    let cln = line('.')
    let clc = getline(l:cln)
    let tmp = ParseBullet(l:clc)
    let clc_pspace = l:tmp['pspace']
    let clc_bullet = l:tmp['bullet']
    let clc_text   = l:tmp['text']
    let remain_space = strlen(l:clc_pspace) % (&shiftwidth)

    if a:direction ==# "LEFT"
        let pspace_num = strlen(l:clc_pspace) - ((l:remain_space != 0) ? (l:remain_space) : &shiftwidth)
        let l:pspace_num = (l:pspace_num < 0) ? 0 : (l:pspace_num)

    else
        let pspace_num = strlen(l:clc_pspace) + ((l:remain_space != 0) ? (&shiftwidth - l:remain_space) : &shiftwidth)

    endif

    let result_line = repeat(' ', l:pspace_num) . l:clc_text

    if l:clc_bullet != ''
        let tmp = GetLastReferenceLine(l:cln, l:pspace_num)
        let llc_bullet = l:tmp['bullet']
        let llc_pspace = l:tmp['pspace']

        if l:pspace_num == 0 && strlen(l:llc_pspace) > 0
            let l:llc_bullet = ''
        endif

        if l:llc_bullet == ''
            let new_bullet = GetBulletLeader(l:clc_bullet, l:pspace_num)

        elseif l:llc_bullet =~# '^[-*+]$'
            " last line is a bulleted list item
            let new_bullet = "*-+"[(l:pspace_num / &shiftwidth) % 3]

        elseif l:llc_bullet == '#.'
            " last line is a (lazy) enumerate list item
            let new_bullet = '#.'

        elseif l:llc_bullet =~# '^\d\+\.$'
            " last line is a enumerate list item
            let new_bullet = (l:llc_bullet + 1) .'.'

        elseif l:llc_bullet =~# '^[a-zA-Z]\.$'
            let new_bullet = nr2char( char2nr(l:llc_bullet) + 1 ) .'.'

        elseif l:llc_bullet =~# '^\d\+)$'
            let new_bullet = ( matchstr(l:llc_bullet, '\(^(\?\)\@<=\d\+\()$\)\@=') + 1 ) .')'

        elseif l:llc_bullet =~# '^(\d\+)$'
            let new_bullet = '('. ( matchstr(l:llc_bullet, '\(^(\?\)\@<=\d\+\()$\)\@=') + 1 ) .')'

        elseif l:llc_bullet =~# '^[a-zA-Z])$'
            let new_bullet = nr2char( char2nr( matchstr(l:llc_bullet, '\(^(\?\)\@<=[a-zA-Z]\()$\)\@=')) + 1 ) .')'

        elseif l:llc_bullet =~# '^([a-zA-Z])$'
            let new_bullet = '('. nr2char( char2nr( matchstr(l:llc_bullet, '\(^(\?\)\@<=[a-zA-Z]\()$\)\@=')) + 1 ) .')'

        else
            let new_bullet = "*-+"[(l:pspace_num / &shiftwidth) % 3]

        endif
        let bullet_space = repeat(' ', &softtabstop - ((l:pspace_num + strlen(l:new_bullet)) % (&softtabstop)) )
        let result_line = repeat(' ', l:pspace_num). l:new_bullet . l:bullet_space . l:clc_text

    endif

    call setline('.', l:result_line)
    normal! ^

endfunction " }}}

function! ParseBullet (line) " {{{
    let pspace = matchstr(a:line, '^ *')
    let bullet = ''
    if a:line =~# s:blpattern
        let bullet = matchstr(a:line, '\(^ *\)\@<=[-*+]\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *[-*+] \+\)\@<=\([^ ].*\)\?$')

    elseif a:line =~# s:elpattern1
        let bullet = matchstr(a:line, '\(^ *\)\@<=\d\+\.\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *\d\+\. \+\)\@<=\([^ ].*\)\?$')

    elseif a:line =~# s:elpattern2
        let bullet = matchstr(a:line, '\(^ *\)\@<=#\.\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *#\. \+\)\@<=\([^ ].*\)\?$')

    elseif a:line =~# s:elpattern3
        let bullet = matchstr(a:line, '\(^ *\)\@<=[a-zA-Z]\.\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *[a-zA-Z]\. \+\)\@<=\([^ ].*\)\?$')

    elseif a:line =~# s:elpattern4
        let bullet = matchstr(a:line, '\(^ *\)\@<=(\?\d\+)\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *(\?\d\+) \+\)\@<=\([^ ].*\)\?$')

    elseif a:line =~# s:elpattern5
        let bullet = matchstr(a:line, '\(^ *\)\@<=(\?[a-zA-Z])\( \+\([^ ].*\)\?$\)\@=')
        let text = matchstr(a:line, '\(^ *(\?[a-zA-Z]) \+\)\@<=\([^ ].*\)\?$')

    else
        let bullet = ''
        let text = matchstr(a:line, '\(^ *\)\@<=[^ ].*$')

    endif

    "echom '['. l:pspace .']['. l:bullet .']['. l:text .']'
    return {'pspace': (l:pspace), 'bullet': (l:bullet), 'text': (l:text)}
endfunction " }}}

inoremap <buffer> <silent> <leader>b <ESC>:call CreateBullet()<CR>a
function! CreateBullet () " {{{
    let cln = line('.')
    let clc = getline(l:cln)
    let tmp = ParseBullet(l:clc)
    let clc_pspace = l:tmp['pspace']
    let clc_bullet = l:tmp['bullet']
    let clc_text   = l:tmp['text']
    let pspace_num = strlen(l:clc_pspace)
    let remain_space = l:pspace_num % (&shiftwidth)

    let pspace_num = l:pspace_num - l:remain_space

    let tmp = GetLastReferenceLine(l:cln, l:pspace_num)
    let llc_bullet = l:tmp['bullet']
    let llc_pspace = l:tmp['pspace']

    if l:llc_bullet != ''
        let l:pspace_num = strlen(l:llc_pspace)
    endif

    if l:llc_bullet == ''
        if l:clc_bullet == ''
            let l:clc_bullet = '*'
        elseif l:clc_bullet =~# '^[-*+]$'
            let l:clc_bullet = '1.'
        elseif l:clc_bullet =~# '^\(\(\d\+\|[a-zA-Z]\|#\)\.\|(\?\(\d\+\|[a-zA-Z]\))\)$'
            let l:clc_bullet = '*'
        endif
        let new_bullet = GetBulletLeader(l:clc_bullet, l:pspace_num)

    elseif l:llc_bullet =~# '^[-*+]$'
        " last line is a bulleted list item
        let new_bullet = "*-+"[(l:pspace_num / &shiftwidth) % 3]

    elseif l:llc_bullet == '#.'
        " last line is a (lazy) enumerate list item
        let new_bullet = '#.'

    elseif l:llc_bullet =~# '^\d\+\.$'
        " last line is a enumerate list item
        let new_bullet = (l:llc_bullet + 1) .'.'

    elseif l:llc_bullet =~# '^[a-zA-Z]\.$'
        let new_bullet = nr2char( char2nr(l:llc_bullet) + 1 ) .'.'

    elseif l:llc_bullet =~# '^\d\+)$'
        let new_bullet = ( matchstr(l:llc_bullet, '\(^(\?\)\@<=\d\+\()$\)\@=') + 1 ) .')'

    elseif l:llc_bullet =~# '^(\d\+)$'
        let new_bullet = '('. ( matchstr(l:llc_bullet, '\(^(\?\)\@<=\d\+\()$\)\@=') + 1 ) .')'

    elseif l:llc_bullet =~# '^[a-zA-Z])$'
        let new_bullet = nr2char( char2nr( matchstr(l:llc_bullet, '\(^(\?\)\@<=[a-zA-Z]\()$\)\@=')) + 1 ) .')'

    elseif l:llc_bullet =~# '^([a-zA-Z])$'
        let new_bullet = '('. nr2char( char2nr( matchstr(l:llc_bullet, '\(^(\?\)\@<=[a-zA-Z]\()$\)\@=')) + 1 ) .')'

    else
        let new_bullet = "*-+"[(l:pspace_num / &shiftwidth) % 3]

    endif

    let bullet_space = repeat(' ', &softtabstop - ((l:pspace_num + strlen(l:new_bullet)) % (&softtabstop)) )
    let result_line = repeat(' ', l:pspace_num). l:new_bullet . l:bullet_space . l:clc_text
    call setline(l:cln, l:result_line)
    call cursor(l:cln, strlen(l:result_line))

endfunction " }}}

inoremap <buffer> <silent> <CR> <C-r>=NewLine()<CR>
function! NewLine () " {{{
    let cln = line('.')
    let clc = getline(l:cln)
    let tmp = ParseBullet(l:clc)
    let clc_pspace = l:tmp['pspace']
    let clc_bullet = l:tmp['bullet']
    let clc_text   = l:tmp['text']
    let pspace_num = strlen(l:clc_pspace)
    let remain_space = l:pspace_num % (&shiftwidth)
    echom '['. l:clc_pspace .']'

    let pspace_num = l:pspace_num - l:remain_space

    if l:clc_bullet == '' && strpart(l:clc_text, 0, col('.')-1) =~# '^.*:: *$'
        return "\<CR>\<CR>". repeat(' ', &shiftwidth)

    elseif l:clc_bullet == ''
        return "\<CR>"

    elseif l:clc_text == ''
        call setline(l:cln, '')
        return "\<CR>\<ESC>i"

    elseif strpart(l:clc_text, 0, col('.')-1) =~# '^.*:: *$'
        return "\<CR>\<CR>\<ESC>i". l:clc_pspace . repeat(' ', &shiftwidth * 2)

    else
        return "\<CR>\<ESC>d0:call CreateBullet()\<CR>a"

    endif

endfunction " }}}
