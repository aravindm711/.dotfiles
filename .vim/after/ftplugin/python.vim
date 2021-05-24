" run file with python3
nnoremap <leader>b :w \| echo system("python3 " . bufname("%"))<CR>

" mappings for commenting and uncommenting input statements
nnoremap <silent> <buffer> <leader>ic :g/sys.stdin/Commentary \| nohlsearch \| w \| normal ''<CR>
