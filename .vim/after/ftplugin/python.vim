setlocal tabstop=4 softtabstop=4 shiftwidth=4
setlocal autoindent

nnoremap <leader>b :w \| :echo system("python3 " . bufname("%"))<CR>

nnoremap <buffer> <leader>ic /sys.stdin<CR>0i#<esc>:noh<CR>:w<CR>
nnoremap <buffer> <leader>iu /sys.stdin<CR>0x:noh<CR>:w<CR>
