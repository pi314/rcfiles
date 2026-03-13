function! MyMappingNerdTreeLeftKey (node)
    if a:node.path.isDirectory && a:node.isOpen
        if synIDattr(synID(line('.'), col('.'), v:false), 'name') == 'NERDTreeCWD'
            " This workaround is so fucking stupid lol
            " The dirnode is root node, close all children
            call g:NERDTreeKeyMap.Invoke(g:NERDTreeMapCloseChildren)
            call s:position_cursor()
        else
            " The dirnode is open, close it
            call a:node.close()
            call NERDTreeRender()
            call s:position_cursor()
        endif
    else
        " Jump to parent
        call g:NERDTreeKeyMap.Invoke(g:NERDTreeMapJumpParent)
        call s:position_cursor()
    endif
endfunction


function! MyMappingNerdTreeRightKey (node)
    if !a:node.isOpen
        call a:node.open()
        call NERDTreeRender()
        call s:position_cursor()
    else
        if a:node.getChildCount()
            normal! j
            call s:position_cursor()
        endif
    endif
endfunction


function! MyMappingNerdTreeUpKey ()
    normal! k0
    call s:position_cursor()
endfunction


function! MyMappingNerdTreeDownKey ()
    normal! j0
    call s:position_cursor()
endfunction


function! s:position_cursor ()
    if synIDattr(synID(line('.'), col('.'), v:false), 'name') == 'NERDTreeCWD'
        normal! ^
        return
    endif

    let del = stridx(getline('.'), g:NERDTreeNodeDelimiter)
    if del != -1
        call cursor(line('.'), del + 1)
    endif
endfunction


call NERDTreeAddKeyMap({
       \ 'key': '<left>',
       \ 'callback': 'MyMappingNerdTreeLeftKey',
       \ 'scope': 'Node',
       \ 'quickhelpText': 'Left', })

call NERDTreeAddKeyMap({
       \ 'key': '<right>',
       \ 'callback': 'MyMappingNerdTreeRightKey',
       \ 'scope': 'DirNode',
       \ 'quickhelpText': 'Right', })

call NERDTreeAddKeyMap({
       \ 'key': '<up>',
       \ 'callback': 'MyMappingNerdTreeUpKey',
       \ 'scope': 'all',
       \ 'quickhelpText': 'Up', })

call NERDTreeAddKeyMap({
       \ 'key': '<down>',
       \ 'callback': 'MyMappingNerdTreeDownKey',
       \ 'scope': 'all',
       \ 'quickhelpText': 'Down', })
