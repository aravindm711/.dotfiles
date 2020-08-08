setlocal cindent
setlocal commentstring=//%s

function Build()
    let l:output = system("g++ -std=c++17 -o binary " . bufname("%"))
    if l:output == ""
	let l:output = system("./binary")
    endif
    echo l:output
endfunction

" compile and run file with c++17
nnoremap <buffer> <leader>b :w \| call Build()<CR>

" mappings for commenting and uncommenting input statements
nnoremap <silent> <buffer> <leader>ic :g/freopen/Commentary \| nohlsearch \| w \| normal ''<CR>
