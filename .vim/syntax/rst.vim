syn match   rstSection      ".*\n([=`'"~^_*+#-])\1*"
syn match   rstBulletList   "^\ *[-*+]\ \+"

hi def link rstSections     Label       " yellow
hi def link rstBulletList   Comment     " cyan
