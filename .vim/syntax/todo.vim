syntax case match

syn region  regex_r_quote
            \ matchgroup=regex_r_quote
            \ contains=regex_pattern
            \ start=_\zsr/\ze_
            \ skip=_\\/_
            \ end=_\zs/\ze_
hi def      regex_r_quote       ctermfg=darkmagenta

syn region  regex_pattern       start=/[^/]/ end=/[^/]/ contained
hi def      regex_pattern       ctermfg=magenta

syn match   rst_link_quote      ,\v`([^`]* +\<.*\>`_)@=,
syn match   rst_link_quote      ,\v(`[^`]* +)@<=\<(.*\>`_)@=,
syn match   rst_link_quote      ,\v(`[^`]* +\<.*)@<=\>`_,
hi def      rst_link_quote      ctermfg=darkcyan

syn match   rst_link_text       ,\v(`)@<=[^`]*( +\<.*\>`_)@=,
hi def      rst_link_text       ctermfg=cyan

syn region  rst_inline_literal_quote
            \ matchgroup=rst_inline_literal_quote
            \ contains=rst_inline_literal_text
            \ start=_\zs``\ze_
            \ end=_\zs``\ze_
hi def      rst_inline_literal_quote    ctermfg=darkmagenta

syn region  rst_inline_literal_text     start=/[^`]/ end=/[^`]/ contained
hi def      rst_inline_literal_text     ctermfg=magenta

syn match   date_string         _\v<[0-9]{2}/[0-9]{2}>_
syn match   date_string         _\v<[0-9]{4}/[0-9]{2}/[0-9]{2}>_
hi def      date_string         cterm=underline ctermfg=white
