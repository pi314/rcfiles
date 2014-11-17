syntax case match

syn match   custom_checkbox     "\[.\]"
syn match   empty_checkbox      "\[ \]"
syn match   checked_checkbox    "\[v\]"
syn match   canceled_checkbox   "\[x\]"
syn match   doing_checkbox      "\[i\]"
syn match   question_checkbox   "\[?\]"
syn match   custom_tag          "\[[^\[\]][^\[\]]\+\]"
syn match   C_comment           "#.*$"
syn region  dquote_string       start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region  squote_string       start=+'+ skip=+\\\\\|\\"+ end=+'+
syn match   date_string         "[0-9][0-9]/[0-9][0-9]"
syn match   important           "\*.*\*"

hi def      empty_checkbox      cterm=bold ctermfg=7 " white
hi def      custom_checkbox     cterm=bold ctermfg=7 " white
hi def      checked_checkbox    cterm=bold ctermfg=2 " green
hi def      canceled_checkbox   cterm=bold ctermfg=1 " red
hi def      doing_checkbox      cterm=bold ctermfg=3 " yellow
hi def      question_checkbox   cterm=bold ctermfg=3 " yellow
hi def      custom_tag          cterm=underline
hi def link C_comment           Comment
hi def link dquote_string       String
hi def link squote_string       String
hi def      date_string         cterm=underline ctermfg=7 " green
hi def link important           Error

" Just for fun
syn match   Google_G            '\<G\(oogle\>\)\@='
syn match   Google_first_o      '\(\<G\)\@<=o\(ogle\>\)\@='
syn match   Google_second_o     '\(\<Go\)\@<=o\(gle\>\)\@='
syn match   Google_g            '\(\<Goo\)\@<=g\(le\>\)\@='
syn match   Google_l            '\(\<Goog\)\@<=l\(e\>\)\@='
syn match   Google_e            '\(\<Googl\)\@<=e\>'
hi def      Google_G            cterm=bold ctermfg=4
hi def      Google_first_o      cterm=bold ctermfg=1
hi def      Google_second_o     cterm=bold ctermfg=3
hi def      Google_g            cterm=bold ctermfg=4
hi def      Google_l            cterm=bold ctermfg=2
hi def      Google_e            cterm=bold ctermfg=1
syn match   facebook            '\<facebook\>'
hi def      facebook            cterm=bold ctermfg=white ctermbg=blue
syn match   Yahoo               '\<Yahoo!'
hi def      Yahoo               cterm=bold ctermfg=magenta
syn match   twitter             '\<twitter\>'
hi def      twitter             cterm=bold ctermfg=7 ctermbg=6
syn match   Mcdonald_M          "\<M\(cdonald's\>\)\@="
syn match   Mcdonald_other      "\(\<M\)\@<=cdonald's\>"
hi def      Mcdonald_M          cterm=bold ctermfg=3 ctermbg=1
hi def      Mcdonald_other      cterm=bold ctermfg=7 ctermbg=1
syn match   Line                '\<Line\>'
hi def      Line                cterm=bold ctermfg=7 ctermbg=2
