syn match   custom_checkbox    "\[.\]"
syn match   empty_checkbox     "\[ \]"
syn match   checked_checkbox   "\[v\]"
syn match   canceled_checkbox  "\[x\]"
syn match   doing_checkbox     "\[i\]"
syn match   question_checkbox  "\[?\]"
syn match   custom_tag         "\[[^\[\]][^\[\]]\+\]"
syn match   C_comment          "#.*$"
syn region  agda_comment       start="--" end="--"
syn region  dquote_string      start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region  squote_string      start=+'+ skip=+\\\\\|\\"+ end=+'+
syn match   date_string        "[0-9][0-9]/[0-9][0-9]"
syn match   important          "\*.*\*"

hi def      empty_checkbox     cterm=bold ctermfg=7 " white
hi def      custom_checkbox    cterm=bold ctermfg=7 " white
hi def      checked_checkbox   cterm=bold ctermfg=2 " green
hi def      canceled_checkbox  cterm=bold ctermfg=1 " red
hi def      doing_checkbox     cterm=bold ctermfg=3 " yellow
hi def      question_checkbox  cterm=bold ctermfg=3 " yellow
hi def      custom_tag         cterm=underline
hi def link C_comment          Comment
hi def link agda_comment       Comment
hi def link dquote_string      String
hi def link squote_string      String
hi def      date_string        cterm=underline ctermfg=7 " green
hi def link important          Error

" rst syntax
syn match   rstSection          /.*\n([=`'"~^_*+#-])\1*/
syn match   rstBulletList       /^\ *[-*+]/
syn match   rstEnumeratedList   /^\ *\d\+\./
syn match   rstEnumeratedList   /^\ *#\./
hi def link rstSections         Label       " yellow
hi def link rstBulletList       Comment     " cyan
hi def link rstEnumeratedList   Comment     " cyan
