" Workaround for NERDTree
" let s:ctrl_g = g:NERDTreeNodeDelimiter
" let s:ro = g:NERDTreeGlyphReadOnly
" let s:pattern = '\v%(^.*\V'. s:ctrl_g .'\v)@<=.*%(\V'. s:ctrl_g .'\v.*\V['. s:ro .']\v$)@='
" exec 'syn match NERDTreeRO #' . s:pattern . '# contains=NERDTreeIgnore,NERDTreeBookmarkName,NERDTreeFile'

let s:ro = g:NERDTreeGlyphReadOnly
exec 'syn match NERDTreeRO /\V['. s:ro .']\v$/'
