syntax case match

syn match   regex_r_quote       _\v<r'(([^\\']|\\.)*')@=_
syn match   regex_r_quote       _\v(<r'([^\\']|\\.)*)@<='_
syn match   regex_r_quote       _\v<r"(([^\\"]|\\.)*")@=_
syn match   regex_r_quote       _\v(<r"([^\\"]|\\.)*)@<="_
syn match   regex_r_quote       _\v<r/(([^\\/]|\\.)*/)@=_
syn match   regex_r_quote       _\v(<r/([^\\/]|\\.)*)@<=/_
hi def      regex_r_quote       ctermfg=darkmagenta

syn match   regex_pattern       _\v(<r')@<=([^\\']|\\.)+'@=_
syn match   regex_pattern       _\v(<r")@<=([^\\"]|\\.)+"@=_
syn match   regex_pattern       _\v(<r/)@<=([^\\/]|\\.)+/@=_
hi def      regex_pattern       ctermfg=magenta

syn match   date_string         _\<[0-9][0-9]/[0-9][0-9]\>_
hi def      date_string         cterm=underline ctermfg=white

" Just for fun
syn match   Google_G            _\v<G(oogle>)@=_
syn match   Google_first_o      _\v(<G)@<=o(ogle>)@=_
syn match   Google_second_o     _\v(<Go)@<=o(gle>)@=_
syn match   Google_g            _\v(<Goo)@<=g(le>)@=_
syn match   Google_l            _\v(<Goog)@<=l(e>)@=_
syn match   Google_e            _\v(<Googl)@<=e>_
hi def      Google_G            cterm=bold ctermfg=blue
hi def      Google_first_o      cterm=bold ctermfg=red
hi def      Google_second_o     cterm=bold ctermfg=yellow
hi def      Google_g            cterm=bold ctermfg=blue
hi def      Google_l            cterm=bold ctermfg=green
hi def      Google_e            cterm=bold ctermfg=red
syn match   facebook            _\v<facebook>_
hi def      facebook            cterm=bold ctermfg=white   ctermbg=blue
syn match   Yahoo               _\v<Yahoo!_
hi def      Yahoo               cterm=bold ctermfg=magenta
syn match   twitter             _\v<twitter>_
hi def      twitter             cterm=bold ctermfg=white   ctermbg=cyan
syn match   Mcdonald_M          _\v<M(cdonald's>)@=_
syn match   Mcdonald_other      _\v(<M)@<=cdonald's>_
hi def      Mcdonald_M          cterm=bold ctermfg=yellow  ctermbg=red
hi def      Mcdonald_other      cterm=bold ctermfg=white   ctermbg=red
syn match   Line                _\v<Line>_
hi def      Line                cterm=bold ctermfg=white   ctermbg=green
syn match   FileZilla           _\v<Fz>_
syn match   FileZilla           _\v<FileZilla>_
hi def      FileZilla           cterm=bold ctermfg=white   ctermbg=red
syn match   UNIQLO_UNI          _\v^UNI(.*\nQLO.*)@=_
syn match   UNIQLO_UNI          _\v^ユニ(.*\nクロ.*)@=_
hi def      UNIQLO_UNI          cterm=bold ctermfg=white   ctermbg=red
syn match   UNIQLO_QLO          _\v(^UNI.*\n)@<=QLO(.*$)@=_
syn match   UNIQLO_QLO          _\v(^ユニ.*\n)@<=クロ(.*$)@=_
hi def      UNIQLO_QLO          cterm=bold ctermfg=white   ctermbg=red
syn match   Microsoft_Mi        _\v^Mi(crosoft\nWindows>)@=_
syn match   Microsoft_cr        _\v(^Mi)@<=cr(osoft\nWindows>)@=_
syn match   Microsoft_Wi        _\v(^Microsoft\n)@<=Wi(ndows>)@=_
syn match   Microsoft_nd        _\v(^Microsoft\nWi)@<=nd(ows>)@=_
hi def      Microsoft_Mi        ctermfg=white ctermbg=red
hi def      Microsoft_cr        ctermfg=white ctermbg=green
hi def      Microsoft_Wi        ctermfg=white ctermbg=blue
hi def      Microsoft_nd        ctermfg=white ctermbg=yellow
syn match   FamilyMart_topline  _\v^\V==========\v\n(FamilyMart\n\V==========\v)@=_
syn match   FamilyMart_text     _\v(^\V==========\v\n)@<=FamilyMart\n(\V==========\v)@=_
syn match   FamilyMart_botline  _\v(^FamilyMart\n)@<=\V==========_
hi def      FamilyMart_topline  ctermfg=green
hi def      FamilyMart_text     ctermfg=blue  ctermbg=white
hi def      FamilyMart_botline  ctermfg=blue
