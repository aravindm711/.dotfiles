function Build()
    let l:output = system("g++ -std=c++17 -o binary " . bufname("%"))
    if l:output == ""
	let l:output = system("./binary")
    endif
    echo l:output
endfunction

setlocal cindent
setlocal commentstring=//%s

nnoremap <buffer> <leader>b :w \| :call Build()<CR>

nnoremap <buffer> <leader>ic /freopen<CR>0i//<esc>:noh<CR>:w<CR>
nnoremap <buffer> <leader>iu /freopen<CR>0xx:noh<CR>:w<CR>
