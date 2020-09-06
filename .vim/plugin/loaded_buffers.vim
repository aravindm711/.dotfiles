" get list of loaded buffers
function! GetLoadedBuffers()
    let g:bufflist = []
    for bufinfo in getbufinfo()
        let g:bufflist += [bufinfo.name]
    endfor
endfunction

" delete list of previously loaded buffers
function! DeletePrevLoadedBuffers()
    for buffername in g:bufflist
        if bufexists(buffername)
            silent execute 'bwipeout ' . buffername
        endif
    endfor
endfunction

" delete all loaded buffers
function! DeleteLoadedBuffers()
    call GetLoadedBuffers()
    call DeletePrevLoadedBuffers()
endfunction

