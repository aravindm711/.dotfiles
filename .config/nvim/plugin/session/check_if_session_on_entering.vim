" obsess if session is detected, on entering vim
function! CheckIfSession()
    if v:this_session != ''
        execute 'Obsession ' . v:this_session
    endif
endfunction

