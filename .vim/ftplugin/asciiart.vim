vnoremap L :call MoveBlock('L')<CR>
vnoremap H :call MoveBlock('H')<CR>
vnoremap K :call MoveBlock('K')<CR>
vnoremap J :call MoveBlock('J')<CR>

function! MoveBlock (direction) range " {{{
    normal! gv

    if mode() != ''
        return
    endif

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

    if a:direction ==# 'L'
        let i = l:minl
        while l:i <= l:maxl
            let line = getline(l:i)
            if strlen(l:line) <= l:maxc
                call setline(l:i, l:line .' ')
            endif
            let l:i = l:i + 1
        endwhile
        normal! dpgvlolo

    elseif a:direction ==# 'H'

        if col('.') == 1
            return
        endif

        let i = l:minl
        while l:i <= l:maxl
            let line = getline(l:i)
            let s1 = strpart(l:line, 0, l:minc-2)
            let s2 = l:line[(l:minc-1):(l:maxc-1)]
            let s3 = l:line[(l:minc-2)]
            let s4 = l:line[(l:maxc):]
            if l:s4 =~# ' \+'
                let l:s4 = ''
            endif
            call setline(l:i, l:s1 . l:s2 . l:s3 . l:s4)
            let l:i = l:i + 1
        endwhile
        normal! gvhoho

    elseif a:direction ==# 'K' || a:direction ==# 'J'

        if l:minl == 1 && a:direction ==# 'K'
            " Move upper than buffer is not permitted
            " you can append some space lines first
            return

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

endfunction " }}}

vnoremap mf :call CreateFrame()<CR>
function! CreateFrame () range " {{{
    normal! gv

    if mode() != ''
        return
    endif

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

    if CheckFrame(l:minl, l:maxl, l:minc, l:maxc)
        let i = l:minl + 1
        while l:i < l:maxl
            let line = getline(l:i)
            call setline(l:i, strpart(l:line, 0, (l:minc-1)) .' '. l:line[(l:minc):(l:maxc-2)] .' '. l:line[(l:maxc):])
            let i = l:i + 1
        endwhile

        let t = repeat(' ', l:maxc - l:minc - 1)
        let line = getline(l:minl)
        call setline(l:minl, strpart(l:line, 0, (l:minc-1)) .' '. l:t .' '. l:line[(l:maxc):] )
        let line = getline(l:maxl)
        call setline(l:maxl, strpart(l:line, 0, (l:minc-1)) ." ". l:t ." ". l:line[(l:maxc):] )

    else
        let i = l:minl + 1
        while l:i < l:maxl
            let line = getline(l:i)
            let s1 = strpart(l:line, 0, (l:minc-1))
            let markup1 = ''
            let s2 = l:line[(l:minc):(l:maxc-2)]

            if strlen(l:line) < (l:minc-1)
                let markup1 = repeat(' ', l:minc - 1 - strlen(l:line))
                let s2 = repeat(' ', l:maxc - l:minc - 1)
            endif

            call setline(l:i, l:s1 . l:markup1 .'|'. l:s2 .'|'. l:line[(l:maxc):])
            let i = l:i + 1
        endwhile

        let t = repeat('-', l:maxc - l:minc - 1)
        let line = getline(l:minl)
        call setline(l:minl, strpart(l:line, 0, (l:minc-1)) .'.'. l:t .'.'. l:line[(l:maxc):] )
        let line = getline(l:maxl)
        call setline(l:maxl, strpart(l:line, 0, (l:minc-1)) ."'". l:t ."'". l:line[(l:maxc):] )

    endif

endfunction " }}}

function! CheckFrame (minl, maxl, minc, maxc) " {{{
    let i = a:minl + 1
    while l:i < a:maxl
        let line = getline(l:i)
        if l:line[(a:minc-1)] != '|' || l:line[(a:maxc-1)] != '|'
            return 0

        endif
        let i = l:i + 1
    endwhile

    let line = getline(a:minl)
    if l:line[(a:minc-1)] != '.' || l:line[(a:maxc-1)] != '.'
        return 0
    endif

    let i = a:minc + 1
    while l:i < a:maxc
        if l:line[(l:i-1)] != '-'
            return 0
        endif
        let i = l:i + 1
    endwhile

    let line = getline(a:maxl)
    if l:line[(a:minc-1)] != "'" || l:line[(a:maxc-1)] != "'"
        return 0
    endif

    let i = a:minc + 1
    while l:i < a:maxc
        if l:line[(l:i-1)] != '-'
            return 0
        endif
        let i = l:i + 1
    endwhile

    return 1

endfunction " }}}
