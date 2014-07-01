" Encoding settings
set encoding=utf-8
set langmenu=zh_TW.UTF-8
language message zh_TW.UTF-8
set fileformat=unix
set ambiwidth=double

" Show mode on bottom-left
set showmode

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
hi TabLine     ctermfg=black ctermbg=white    "not active tab page label
hi TabLineSel  ctermfg=grey  ctermbg=black    "active tab page label
hi TabLineFill ctermfg=grey  ctermbg=white    "fill the other place
hi VIMlogo     ctermfg=white ctermbg=blue

" Hot-keys
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
nmap <ESC>OA :call Arrow_move("up")<CR>
nmap <ESC>OB :call Arrow_move("down")<CR>
nmap <ESC>OC :call Arrow_move("right")<CR>
nmap <ESC>OD :call Arrow_move("left")<CR>

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


" My functions!

" Add a line under a rst title
function! Title(type)
    if len(a:type) == 1
        execute "normal yyp$r" . a:type
    else
        echom "Title type must be only one charactor"
    endif
endfunction
command! -nargs=1 Title call Title(<f-args>)

" Resize split window functions
let g:flag_resizing_window = "false"
function! Set_resize_window_flag(value)
    if a:value == "start" || a:value == 'true' || a:value == 'on'
        let g:flag_resizing_window = "true"
    elseif a:value == "end" || a:value == 'false' || a:value == 'off'
        let g:flag_resizing_window = "false"
    endif

    if g:flag_resizing_window == "true"
        echom "Start Resizing window, use arrow key to resize window."
    elseif g:flag_resizing_window == 'false'
        echom "Resizing window ended."
    endif
endfunction
command! -nargs=1 Resize call Set_resize_window_flag(<f-args>)

function! Arrow_move(dir)
    if g:flag_resizing_window == "true"
        let acc_sign = ''
        if a:dir == 'up' || a:dir == 'left'
            let acc_sign = '-'
        elseif a:dir == 'down' || a:dir == 'right'
            let acc_sign = '+'
        endif

        let acc_cmd  = ''
        if a:dir == 'up' || a:dir == 'down'
            let acc_cmd = 'res'
        elseif a:dir == 'left' || a:dir == 'right'
            let acc_cmd = 'vertical resize'
        endif
        execute ':silent ' . acc_cmd . ' ' . acc_sign . '1'
        echom "Use arrow key to resize window and :Resize end to finish."
    elseif g:flag_resizing_window == "false"
        if a:dir == 'up'
            normal k
        elseif a:dir == 'left'
            normal h
        elseif a:dir == 'right'
            normal l
        elseif a:dir == 'down'
            normal j
        endif
        echom ""
    endif
endfunction
