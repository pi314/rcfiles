" encoding settings
set encoding=utf-8
set langmenu=zh_TW.UTF-8
language message zh_TW.UTF-8
set fileformat=unix
set ambiwidth=double

" show mode on bottom-left
set showmode

" color settings
syntax on
set hlsearch
set bg=dark

" tab charactor related settings
set expandtab
set tabstop=4
set listchars=tab:>-
set list

" ignore case on searching
set ic

" show the coordinate of cursor
set ru

" enable backspace
set bs=2

" tabline setting in .vim/plugin/tabline.vim
hi TabLine     ctermfg=black ctermbg=white    "not active tab page label
hi TabLineSel  ctermfg=grey  ctermbg=black    "active tab page label
hi TabLineFill ctermfg=grey  ctermbg=white    "fill the other place
hi VIMlogo     ctermfg=white ctermbg=blue

" hot-keys
nmap <C-j> :tabp<CR>
imap <C-j> <ESC><C-j>a
nmap <C-k> :tabn<CR>
imap <C-k> <ESC><C-k>a
nmap <C-t> :tabe<SPACE>
imap <C-t> <ESC><C-t>
nmap <C-p> :tabm -1<CR>
imap <C-p> <ESC><C-p>a<CR>
nmap <C-n> :tabm +1<CR>
imap <C-n> <ESC><C-n>a<CR>
imap <ESC>[Z <ESC><<I

" show line numbers
set nu

" indent related settings
"set cindent
set ai
set shiftwidth=4

" status line
set laststatus=2
set wildmenu

set scrolloff=5

