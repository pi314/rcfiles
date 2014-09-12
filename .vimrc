" Encoding settings
set encoding=utf-8
set langmenu=zh_TW.UTF-8
language message zh_TW.UTF-8
set fileformat=unix
set ambiwidth=double

" Show mode on bottom-left
set showmode

" Show command on bottom-right
set showcmd

" Color settings
syntax on
set hlsearch
set bg=dark

" Tab charactor related settings
set expandtab       " changes user pressed TAB to spaces
set tabstop=4       " changes the width of the TAB character
set shiftwidth=4    " >>, <<, == width and automatic indent width
set listchars=tab:>-
set list
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType xml  setlocal shiftwidth=2 tabstop=2
autocmd FileType make setlocal noexpandtab

" Ignore case on searching
set ic

" Show the coordinate of cursor
set ru

" Enable backspace
set bs=2

" Tabline setting in .vim/plugin/tabline.vim
hi TabLine     ctermfg=black ctermbg=grey     "not active tab page label
hi TabLineSel  ctermfg=grey  ctermbg=black    "active tab page label
hi TabLineFill ctermfg=grey  ctermbg=white    "fill the other place
hi VIMlogo     ctermfg=white ctermbg=blue

" Hot-keys

" move moving between long wrapped lines
" must use nnoremap #no recursive map
nnoremap k gk
nnoremap j gj

nmap <C-j> :tabp<CR>
imap <C-j> <ESC><C-j>a
nmap <C-k> :tabn<CR>
imap <C-k> <ESC><C-k>a

nmap <C-t> :tabe<SPACE>
imap <C-t> <ESC><C-t>

nmap <C-p> :tabm -1<CR>
imap <C-p> <ESC><C-p>a
nmap <C-n> :tabm +1<CR>
imap <C-n> <ESC><C-n>a

" generate a checkbox at the beginning of line
nmap <C-c> :call Add_checkbox()<CR>
imap <C-c> <ESC>:call Add_checkbox()<CR>
vmap <C-c> :call Add_checkbox()<CR>

" brackets
command! -nargs=1 Br call Bracket_replace(<f-args>)
command! -nargs=1 BR call Bracket_replace(<f-args>)
" This function uses mark z
function! Bracket_replace (from_to)
    if len(a:from_to) != 2
        echom "The argument must be two charactors"
        return
    endif

    let l:from = a:from_to[0]
    let l:to = a:from_to[1]

    if l:from == '(' || l:from == ')' || l:from ==# 'b'
        let l:from = '('

    elseif l:from == '[' || l:from == ']'
        let l:from = '['

    elseif l:from == '{' || l:from == '}' || l:from ==# 'B'
        let l:from = '{'

    elseif l:from == '<' || l:from == '>'
        let l:from = '<'

    elseif l:from == '"'
        let l:from = '"'

    elseif l:from == "'"
        let l:from = "'"

    else
        echom 'Unrecognized argument '. l:from
        return

    endif

    if l:to == '(' || l:to == ')' || l:to ==# 'b'
        let l:replacement = '()'

    elseif l:to == '[' || l:to == ']'
        let l:replacement = '[]'

    elseif l:to == '{' || l:to == '}' || l:to ==# 'B'
        let l:replacement = '{}'

    elseif l:to == '<' || l:to == '>'
        let l:replacement = '<>'

    elseif l:to == '"'
        let l:replacement = '""'

    elseif l:to == "'"
        let l:replacement = "''"

    else
        echom 'Unrecognized argument '. l:to
        return

    endif

    """ clear mark z
    execute 'delmarks z'
    execute 'normal di'. l:from
    if l:from ==# '"' || l:from ==# "'"
        execute "normal h"
    else
        execute "normal %"
    endif
    " I am now at left bracket position
    execute 'normal mz'
    execute 'normal u'
    execute 'normal `z'
    if l:from ==# '"' || l:from ==# "'"
        execute 'normal f'. l:from
    else
        execute 'normal %'
    endif
    " I am now at right bracket position
    execute 'normal r'.l:replacement[1]
    execute 'normal `z'
    execute 'normal `zr'.l:replacement[0]

    "echom l:from . l:to

endfunction

" Show line numbers
set nu

" Indent related settings

" Set cindent
set ai
set shiftwidth=4

" Status line
set laststatus=2
set wildmenu

set scrolloff=5

"""" My functions!

" Add a line under a rst title
command! -nargs=1 Title call Title(<f-args>)
function! Title(type)
    if len(a:type) == 1
        execute "normal yyp$r" . a:type
    else
        echom "Title type must be only one charactor"
    endif
endfunction

function! Add_checkbox ()
    let l:line = getline('.')

    let l:prefix_space = matchstr(l:line, '^ *')
    let l:after_space_data = l:line[strlen(l:prefix_space):]

    if l:after_space_data[0:2] == '[ ]'
        let l:after_space_data = '[v]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] == '[v]'
        let l:after_space_data = '[x]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] == '[x]'
        let l:after_space_data = '[ ]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] =~ '^\[.\]$'
        let l:after_space_data = '[ ]' . l:after_space_data[3:]

    else
        let l:after_space_data = '[ ] ' . l:after_space_data
    endif

    call setline('.', l:prefix_space . l:after_space_data)
    execute "normal ^l"
    echom ""
endfunction
