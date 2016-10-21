" Vertical line color settings
highlight ColorColumn ctermbg=Blue

" Completion menu color settings
highlight Pmenu     ctermfg=White ctermbg=Blue gui=bold
highlight PmenuSel  ctermfg=Black ctermbg=Cyan gui=bold

" Tabline setting in .vim/plugin/tabline.vim
highlight TabLine       ctermfg=black ctermbg=grey     " not active tab page label
highlight TabLineSel    ctermfg=grey  ctermbg=black    " active tab page label
highlight TabLineFill   ctermfg=grey  ctermbg=white    " fill the other place
highlight VIMlogo       ctermfg=white ctermbg=blue

" Trailing spaces
highlight def   trailing_spaces ctermbg=red
match           trailing_spaces _\v\s+$_
