function! Add_checkbox ()
    let l:line = getline('.')

    let l:prefix_space = matchstr(l:line, '^ *')
    let l:after_space_data = l:line[strlen(l:prefix_space):]

    if l:after_space_data[0:2] == '[ ]'
        let l:after_space_data = '[v]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] == '[v]'
        let l:after_space_data = '[x]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] == '[x]'
        let l:after_space_data = '[ ]' . l:after_space_data[3:]

    elseif l:after_space_data[0:2] =~ '^\[.\]$'
        let l:after_space_data = '[ ]' . l:after_space_data[3:]

    else
        let l:after_space_data = '[ ] ' . l:after_space_data
    endif

    call setline('.', l:prefix_space . l:after_space_data)
    execute "normal ^l"
    echom ""
endfunction

" generate a checkbox at the beginning of line
nmap <buffer> <C-c> :call Add_checkbox()<CR>
imap <buffer> <C-c> <ESC>:call Add_checkbox()<CR>
vmap <buffer> <C-c> :call Add_checkbox()<CR>
