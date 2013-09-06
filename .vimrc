"編碼相關設定
set encoding=utf-8
set langmenu=zh_TW.UTF-8
language message zh_TW.UTF-8
set fileformat=unix
set ambiwidth=double

"在左下角顯示模式
set showmode

"顏色相關設定
syntax on
set hlsearch
set bg=dark

"tab 字元相關
set expandtab
set tabstop=4
set listchars=tab:>-
set list

set ic           " 設定搜尋忽略大小寫
set ru           " 第幾行第幾個字

"設定可以使用backspace
set bs=2

"tabline settin in .vim/plugin/tabline.vim
hi TabLine     ctermfg=black ctermbg=white    "not active tab page label
hi TabLineSel  ctermfg=grey  ctermbg=black    "active tab page label
hi TabLineFill ctermfg=grey  ctermbg=white    "fill the other place
hi VIMlogo     ctermfg=white ctermbg=blue
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

"顯示行號
set nu

"自動縮排
"set cindent
set ai
"set ai == set autoindent
set shiftwidth=4

"狀態列
set laststatus=2
set wildmenu

"游標留底
set scrolloff=5

