
let g:pbuffList = []

function! persistent-split#MakePersistent(buffNr)
    call append(g:pbuffList, a:buffNr)
endfunction

function! persistent-split#UnmakePersistent(buffNr)
    call remove(g:pbuffList, a:buffNr)
endfunction

function! persistent-split#NewPersistent(position)
endfunction

function! persistent-split#NewVerticalPersistent()
endfunction

function! persistent-split#NewHorizontalPersistent()
endfunction

function! persistent-split#KeepPersistent()
    for l:buff in g:pbuffList
        vsp l:buff
endfunction

autocmd! BufNew * call persistent-split#KeepPersistent()

command! MakePersistent call persistent-split#MakePersistent(bufnr('%'))
command! UnmakePersistent call persistent-split#UnmakePersistent(bufnr('%'))
