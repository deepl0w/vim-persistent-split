
let g:pbuffDict = {}

function! MakePersistent(buffNr)
    let g:pbuffDict[a:buffNr] = [winwidth(winnr()), winheight(winnr())]
endfunction

function! UnmakePersistent(buffNr)
    call remove(g:pbuffDict, a:buffNr)
endfunction

function! NewPersistent(position)
endfunction

function! NewVerticalPersistent()
    vnew
    MakePersistent(bufnr('%'))
endfunction

function! NewHorizontalPersistent()
    new
    call MakePersisten(bufnr('%'))
endfunction

function! KeepPersistent()
    for l:buff in keys(g:pbuffDict)
        let l:w = g:pbuffDict[l:buff][0]
        let l:h = g:pbuffDict[l:buff][1]

        if l:w > l:h
            execute 'sp | buf ' . l:buff
        else
            execute 'vsp | buf ' . l:buff
        endif
        execute 'vertical resize  ' . g:pbuffDict[l:buff][0]
        execute 'resize ' . g:pbuffDict[l:buff][1]
        set wfh
        set wfw
    endfor
endfunction

function! ChangeSplitCount(buffNr, nr)
    if has_key(g:pbuffDict, a:buffNr)
        let g:pbuffDict[a:buffNr] += a:nr

        if g:pbuffDict[a:buffNr] == 0
            call UnmakePersistent(a:buffNr)
        endif
endif
endfunction


autocmd! TabNewEntered * call KeepPersistent()
"autocmd! TabNew * call ChangeSplitCount(bufnr('%'), 1)
"autocmd! BufWinLeave * call ChangeSplitCount(bufnr('%'), -1)

command! MakePersistent call MakePersistent(bufnr('%'))
command! UnmakePersistent call UnmakePersistent(bufnr('%'))
