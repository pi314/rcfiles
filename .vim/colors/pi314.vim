" Vim color file
" based on torte.vim maintained by Thorsten Maerz <info@netztorte.de>
let g:colors_name = "pi314"

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

highlight Normal     guifg=Grey80       guibg=Black     gui=None
highlight Normal     ctermfg=LightGrey  ctermbg=Black   cterm=bold

highlight Search     guifg=Black        guibg=Yellow    gui=bold
highlight Search     ctermfg=Black      ctermbg=Yellow  cterm=NONE

highlight Visual     guifg=#404040                      gui=bold
highlight Visual                                        cterm=reverse

highlight Cursor     guifg=Black        guibg=Green     gui=bold
highlight Cursor     ctermfg=Black      ctermbg=Green   cterm=bold

highlight Special    guifg=Orange
highlight Special    ctermfg=Brown

highlight Comment    guifg=#80a0ff
highlight Comment    ctermfg=Blue

highlight StatusLine guifg=Black        guibg=Grey      gui=bold
highlight StatusLine ctermfg=Black      ctermbg=grey    cterm=bold

highlight Statement  guifg=Yellow                       gui=NONE
highlight Statement  ctermfg=Yellow                     cterm=NONE

highlight Type                                          gui=NONE
highlight Type                                          cterm=NONE


" Vertical line color settings
highlight ColorColumn guibg=Blue
highlight ColorColumn ctermbg=Blue


" Completion menu color settings
highlight Pmenu     guifg=White     guibg=Blue      gui=bold
highlight Pmenu     ctermfg=White   ctermbg=Blue

highlight PmenuSel  guifg=Black     guibg=Cyan      gui=bold
highlight PmenuSel  ctermfg=Black   ctermbg=Cyan


" Tabline setting in .vim/plugin/tabline.vim
highlight TabLine       ctermfg=Black   ctermbg=Grey     " not active tab page label
highlight TabLineSel    ctermfg=Grey    ctermbg=Black    " active tab page label
highlight TabLineFill   ctermfg=Grey    ctermbg=White    " fill the other place
highlight VIMlogo       ctermfg=White   ctermbg=Blue


" Trailing spaces
highlight ExtraWhitespace               guibg=Red
highlight ExtraWhitespace               ctermbg=Red
autocmd BufWinEnter * match ExtraWhitespace /\v\s+$/
