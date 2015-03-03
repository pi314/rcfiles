syntax case match

syn match   custom_checkbox     "\[.\]"
syn match   empty_checkbox      "\[ \]"
syn match   checked_checkbox    "\[v\]"
syn match   canceled_checkbox   "\[x\]"
syn match   doing_checkbox      "\[i\]"
syn match   question_checkbox   "\[?\]"
hi def      empty_checkbox      cterm=bold ctermfg=white
hi def      custom_checkbox     cterm=bold ctermfg=white
hi def      checked_checkbox    cterm=bold ctermfg=green
hi def      canceled_checkbox   cterm=bold ctermfg=red
hi def      doing_checkbox      cterm=bold ctermfg=yellow
hi def      question_checkbox   cterm=bold ctermfg=yellow

syn match   C_comment           "#.*$"
hi def link C_comment           Comment

syn match   regex_r_quote       '\<r/\([^/]*/\)\@='
syn match   regex_r_quote       "\<r'\([^']*'\)\@="
syn match   regex_r_quote       '\<r"\([^"]*"\)\@='
syn match   regex_r_quote       '\(\<r/[^/]*\)\@<=/'
syn match   regex_r_quote       "\(\<r'[^']*\)\@<='"
syn match   regex_r_quote       '\(\<r"[^"]*\)\@<="'
syn match   regex_r_quote       '\<r//'
syn match   regex_r_quote       "\<r''"
syn match   regex_r_quote       '\<r""'
syn match   regex_pattern       '\(\<r/\)\@<=[^/]*\(/\)\@='
syn match   regex_pattern       "\(\<r'\)\@<=[^']*\('\)\@="
syn match   regex_pattern       '\(\<r"\)\@<=[^"]*\("\)\@='
hi def      regex_r_quote                  ctermfg=darkmagenta
hi def      regex_pattern       cterm=bold ctermfg=magenta

syn region  dquote_string       start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region  squote_string       start=+'+ skip=+\\\\\|\\"+ end=+'+
hi def link dquote_string       String
hi def link squote_string       String

syn match   date_string         "\<[0-9][0-9]/[0-9][0-9]\>"
hi def      date_string         cterm=underline ctermfg=white


" Just for fun
syn match   Google_G            '\<G\(oogle\>\)\@='
syn match   Google_first_o      '\(\<G\)\@<=o\(ogle\>\)\@='
syn match   Google_second_o     '\(\<Go\)\@<=o\(gle\>\)\@='
syn match   Google_g            '\(\<Goo\)\@<=g\(le\>\)\@='
syn match   Google_l            '\(\<Goog\)\@<=l\(e\>\)\@='
syn match   Google_e            '\(\<Googl\)\@<=e\>'
hi def      Google_G            cterm=bold ctermfg=blue
hi def      Google_first_o      cterm=bold ctermfg=red
hi def      Google_second_o     cterm=bold ctermfg=yellow
hi def      Google_g            cterm=bold ctermfg=blue
hi def      Google_l            cterm=bold ctermfg=green
hi def      Google_e            cterm=bold ctermfg=red
syn match   facebook            '\<facebook\>'
hi def      facebook            cterm=bold ctermfg=white   ctermbg=blue
syn match   Yahoo               '\<Yahoo!'
hi def      Yahoo               cterm=bold ctermfg=magenta
syn match   twitter             '\<twitter\>'
hi def      twitter             cterm=bold ctermfg=white   ctermbg=cyan
syn match   Mcdonald_M          "\<M\(cdonald's\>\)\@="
syn match   Mcdonald_other      "\(\<M\)\@<=cdonald's\>"
hi def      Mcdonald_M          cterm=bold ctermfg=yellow  ctermbg=red
hi def      Mcdonald_other      cterm=bold ctermfg=white   ctermbg=red
syn match   Line                '\<Line\>'
hi def      Line                cterm=bold ctermfg=white   ctermbg=green
syn match   FileZilla           '\<Fz\>'
syn match   FileZilla           '\<FileZilla\>'
hi def      FileZilla           cterm=bold ctermfg=white   ctermbg=red
syn match   UNIQLO_UNI          '^UNI\(.*\nQLO.*\)\@='
syn match   UNIQLO_UNI          '^ユニ\(.*\nクロ.*\)\@='
hi def      UNIQLO_UNI          cterm=bold ctermfg=white   ctermbg=red
syn match   UNIQLO_QLO          '\(^UNI.*\n\)\@<=QLO\(.*$\)\@='
syn match   UNIQLO_QLO          '\(^ユニ.*\n\)\@<=クロ\(.*$\)\@='
hi def      UNIQLO_QLO          cterm=bold ctermfg=white   ctermbg=red
