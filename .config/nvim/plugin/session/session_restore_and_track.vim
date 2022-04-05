" start obsession while restoring a session
function! SessionRestoreAndTrack(session)
    redraw
    if v:this_session == a:session
        echo 'selected session is already open'
    else
        silent execute 'wa'
        call GetLoadedBuffers()
        silent execute 'source ' . a:session
        call DeletePrevLoadedBuffers()
        execute 'Obsession ' . a:session
    endif
endfunction
