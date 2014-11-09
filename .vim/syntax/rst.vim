syn match   rstSection          /.*\n([=`'"~^_*+#-])\1*/
syn match   rstBulletList       /^\ *[-*+]\(\ \)\@=/
syn match   rstEnumeratedList   /^\ *\d\+\.\(\ \)\@=/
syn match   rstEnumeratedList   /^\ *#\.\(\ \)\@=/

hi def link rstSections         Label       " yellow
hi def link rstBulletList       Comment     " cyan
hi def link rstEnumeratedList   Comment     " cyan
