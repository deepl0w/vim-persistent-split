
let g:pbuffList = []

function! s:persistent-split#MakePersistent(buffNr)
    call append(g:pbuffList, a:buffNr)
endfunction

function! s:persistent-split#UnmakePersistent(buffNr)
    call remove(g:pbuffList, a:buffNr)
endfunction

function! s:persistent-split#NewPersistent(position)
endfunction

function! s:persistent-split#NewVerticalPersistent()
endfunction

function! s:persistent-split#NewHorizontalPersistent()
endfunction

function! s:persistent-split#KeepPersistent()
    for l:buff in g:pbuffList
        vsp l:buff
endfunction

autocmd! BufNew * call s:persistent-split#KeepPersistent()

command! MakePersistent call s:persistent-split#MakePersistent(bufnr('%'))
command! UnmakePersistent call s:persistent-split#UnmakePersistent(bufnr('%'))
