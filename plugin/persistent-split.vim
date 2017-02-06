
let g:pbuffDict = {}

function! MakePersistent(buffNr)
    let g:pbuffDict[a:buffNr] = 1
endfunction

function! UnmakePersistent(buffNr)
    call remove(g:pbuffDict, a:buffNr)
endfunction

function! NewPersistent(position)
endfunction

function! NewVerticalPersistent()
endfunction

function! NewHorizontalPersistent()
endfunction

function! KeepPersistent()
    for l:buff in keys(g:pbuffDict)
        vsp l:buff
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
autocmd! BufWinEnter * call ChangeSplitCount(bufnr('%'), 1)
autocmd! BufWinLeave * call ChangeSplitCount(bufnr('%'), -1)

command! MakePersistent call MakePersistent(bufnr('%'))
command! UnmakePersistent call UnmakePersistent(bufnr('%'))
