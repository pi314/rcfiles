set encoding=utf-8
set langmenu=zh_TW.UTF-8
language message zh_TW.UTF-8
set fileformat=unix
set ambiwidth=double
syntax on
"寬度為4
set expandtab
set tabstop=4
"設定可以使用backspace
set bs=2
"tabline settin in .vim/plugin/tabline.vim
hi TabLine     ctermfg=black ctermbg=white    "not active tab page label
hi TabLineSel  ctermfg=white ctermbg=black    "active tab page label
hi TabLineFill ctermfg=white ctermbg=blue     "fill the other place
hi VIMlogo     ctermfg=white ctermbg=blue
nmap <C-j> :tabp<CR>
imap <C-j> <ESC><C-j>a
nmap <C-k> :tabn<CR>
imap <C-k> <ESC><C-k>a
nmap <C-t> :tabe<SPACE>
imap <C-t> <ESC><C-t>
imap <C-p> <ESC>a

"顯示行號
set nu

"自動縮排
"set cindent
set ai
"set ai == set autoindent
set shiftwidth=4

"游標線
"set cul

"狀態列
set laststatus=2

"游標留底
set scrolloff=5

"自動備份
"set backup
"set backupdir=~/.backup
"設定F9編譯並執行
"function! HasError(qflist)
"for i in a:qflist
"    if i.valid == 1
"        return 1
"     endif
"endfor
"return 0
"endfunction
"
"function! MakeAndRun()
"    make \"%:r"
"    if HasError( getqflist() )
"        cl
"    else
"        !mv \"%:r" a.out
"        !./a.out
"    endif
"endfunction
"
"map <F9> :w<CR>:call MakeAndRun()<CR>
"imap <F9> <ESC><F9>
"map <F4> :cl<CR>
"imap <F4> <ESC><F4>
"map <F5> :cn<CR><F4>
"imap <F5> <ESC><F5>
"map <F6> :cp<CR><F4>
"imap <F6> <ESC><F6>

