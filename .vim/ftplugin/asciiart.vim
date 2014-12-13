vnoremap L :call Move_Block('L')<CR>
vnoremap H :call Move_Block('H')<CR>
vnoremap K :call Move_Block('K')<CR>
vnoremap J :call Move_Block('J')<CR>

function! Move_Block (direction) range
    normal! gv

    if mode() != ''
        return

    elseif a:direction ==# 'L'
        normal! dpgvlolo

    elseif a:direction ==# 'H'
        normal! d
        if col('.') == 1
            normal! Pgv

        else
            normal! hPgvhoho

        endif

    elseif a:direction ==# 'K' || a:direction ==# 'J'

        " retrive visual block range
        let minl = line('.')
        let maxl = line('.')
        let minc = col('.')
        let maxc = col('.')

        normal! o
        let newl = line('.')
        let newc = col('.')
        normal! o
        let minl = l:minl < l:newl ? (l:minl) : (l:newl)
        let maxl = l:maxl > l:newl ? (l:maxl) : (l:newl)
        let minc = l:minc < l:newc ? (l:minc) : (l:newc)
        let maxc = l:maxc > l:newc ? (l:maxc) : (l:newc)

        " if the block is at the edge of vim buffer, extend it
        if l:minl == 1 && a:direction ==# 'K'
            call append(0, '')

        elseif l:maxl == line('$') && a:direction ==# 'J'
            call append(line('$'), '')

        endif

        " scroll line number - sln
        " tailing line number - fln
        if a:direction ==# 'K'
            let sln = l:minl - 1
            let fln = l:minl - 1
            let edge = l:maxl

        elseif a:direction ==# 'J'
            let sln = l:maxl + 1
            let fln = l:minl + 1
            let edge = l:minl

        endif

        " scroll line content
        let slc = getline(l:sln)
        let makeup_space = repeat(' ', l:maxc - strlen(l:slc))
        call setline(l:sln, l:slc . l:makeup_space)

        let slc = getline(l:sln)
        let cut_content = l:slc[(l:minc-1):(l:maxc-1)]
        call setline(l:sln, l:slc[:(l:minc-2)] . l:slc[(l:maxc):] )

        " move the text
        normal! d
        call cursor(l:fln, l:minc)
        if strlen(getline(l:fln)) < l:minc
            normal! p
        else
            normal! P
        endif

        " remain line content
        let rlc = getline(l:edge)
        call setline(l:edge, l:rlc[ : (l:minc-2)] . l:cut_content . l:rlc[(l:minc-1) : ] )

        if a:direction ==# 'K'
            normal! gvkoko
        elseif a:direction ==# 'J'
            normal! gvjojo
        endif

    endif

endfunction
