syn match   rstBulletList       /\(^\ *\)\@<=[-*+]\(\ \)\@=/
hi def link rstBulletList       Comment     " cyan

syn match   rstSimpleTableLines /^ *=\+\( \+=\+\)\+$/

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
hi def link rstEnumeratedList   Comment     " cyan

hi def link rstSections         Label       " yellow

syn match   rstFieldList        /^:[^:]\+: \+.*$/
syn match   rstFieldList        /^:[^:]\+: \+.*\n\( \+\).*\(\n\1.*\)*/
hi def link rstFieldList        Function

