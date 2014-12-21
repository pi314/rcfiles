syn match   rstSection          /.*\n([=`'"~^_*+#-])\1*/
syn match   rstBulletList       /\(^\ *\)\@<=[-*+]\(\ \)\@=/

" 1.
syn match   rstEnumeratedList   /\(^\ *\)\@<=\d\+\.\(\ \)\@=/
" #.
syn match   rstEnumeratedList   /\(^\ *\)\@<=#\.\(\ \)\@=/
" a.    A.
syn match   rstEnumeratedList   /\(^\ *\)\@<=[a-zA-Z]\.\(\ \)\@=/
" (12)  12)
syn match   rstEnumeratedList   /\(^\ *\)\@<=(\?\d\+)\(\ \)\@=/
" a)    A)  (a) (A)
syn match   rstEnumeratedList   /\(^\ *\)\@<=(\?[a-zA-Z])\(\ \)\@=/

hi def link rstSections         Label       " yellow
hi def link rstBulletList       Comment     " cyan
hi def link rstEnumeratedList   Comment     " cyan
