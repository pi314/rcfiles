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
" highlight Normal     ctermfg=LightGrey  ctermbg=Black   cterm=bold
highlight Normal     ctermfg=LightGrey                  cterm=bold

highlight Search     guifg=Black        guibg=Yellow    gui=bold
highlight Search     ctermfg=Black      ctermbg=Yellow

highlight Visual     guifg=#404040                      gui=bold
highlight Visual                                        cterm=reverse

highlight Cursor     guifg=Black        guibg=Green     gui=bold
highlight Cursor     ctermfg=Black      ctermbg=Green   cterm=bold

highlight Special    guifg=Orange
highlight Special    ctermfg=Red

highlight Comment    guifg=#80a0ff
highlight Comment    ctermfg=Cyan

highlight StatusLine guifg=Black        guibg=Grey      gui=bold
highlight StatusLine ctermfg=Black      ctermbg=grey    cterm=bold

highlight Statement  guifg=Yellow                       gui=NONE
highlight Statement  ctermfg=Yellow

highlight Type                                          gui=NONE
highlight Type       ctermfg=Green


" Vertical line color settings
highlight ColorColumn guibg=Blue
highlight ColorColumn ctermbg=Blue


" Completion menu color settings
highlight Pmenu     guifg=White     guibg=Blue      gui=bold
highlight Pmenu     ctermfg=White   ctermbg=Blue

highlight PmenuSel  guifg=Black     guibg=Cyan      gui=bold
highlight PmenuSel  ctermfg=Black   ctermbg=Cyan

" Tab line settings
highlight TabLine       cterm=bold  ctermfg=Black       ctermbg=LightGray
highlight TabLineSel    cterm=bold  ctermfg=LightGray   ctermbg=Black
highlight TabLineFill   cterm=bold  ctermfg=LightGray   ctermbg=LightGray
highlight TabLine       gui=bold    guifg=Black         guibg=LightGray
highlight TabLineSel    gui=bold    guifg=LightGray     guibg=Black
highlight TabLineFill   gui=bold    guifg=LightGray     guibg=LightGray


" Trailing spaces
highlight ExtraWhitespace               guibg=Red
highlight ExtraWhitespace               ctermbg=Red
autocmd BufWinEnter * match ExtraWhitespace /\v\s+$/


" Diff highlights
highlight DiffText      ctermfg=black   ctermbg=yellow
highlight DiffChange                    ctermbg=DarkMagenta
