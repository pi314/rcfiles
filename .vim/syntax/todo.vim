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

syn match   rst_link_quote      ,\v`([^`]* +\<.*\>`_)@=,
syn match   rst_link_quote      ,\v(`[^`]* +)@<=\<(.*\>`_)@=,
syn match   rst_link_quote      ,\v(`[^`]* +\<.*)@<=\>`_,
hi def      rst_link_quote      ctermfg=darkcyan

syn match   rst_link_text       ,\v(`)@<=[^`]*( +\<.*\>`_)@=,
hi def      rst_link_text       ctermfg=cyan

syn match   rst_inline_literal_quote    _\v``([^ ].{-}[^ ]``)@=_
syn match   rst_inline_literal_quote    _\v(``[^ ].{-}[^ ])@<=``_
syn match   rst_inline_literal_quote    _\v``([^ ]``)@=_
syn match   rst_inline_literal_quote    _\v(``[^ ])@<=``_
hi def      rst_inline_literal_quote    ctermfg=darkmagenta

syn match   rst_inline_literal_text     _\v(``)@<=[^ ].{-}[^ ](``)@=_
syn match   rst_inline_literal_text     _\v(``)@<=[^ ](``)@=_
hi def      rst_inline_literal_text     ctermfg=magenta

syn match   date_string         _\v<[0-9]{2}/[0-9]{2}>_
syn match   date_string         _\v<[0-9]{4}/[0-9]{2}/[0-9]{2}>_
hi def      date_string         cterm=underline ctermfg=white
