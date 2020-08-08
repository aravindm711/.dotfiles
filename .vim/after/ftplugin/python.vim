" insert indented newline if surrounded by brackets
function! InsertMapForEnter()
    if pumvisible()
        return "\<C-y>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<CR>\<Esc>\<\<ki\<Tab>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == ')'
        return "\<CR>\<CR>\<Esc>\<\<ki\<Tab>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == ']'
        return "\<CR>\<CR>\<Esc>\<\<ki\<Tab>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<CR>\<Esc>\<\<ki\<Tab>"
    else
        return "\<CR>"
    endif
endfunction

" run file with python3
nnoremap <leader>b :w \| echo system("python3 " . bufname("%"))<CR>

" mappings for commenting and uncommenting input statements
nnoremap <silent> <buffer> <leader>ic :g/sys.stdin/Commentary \| nohlsearch \| w \| normal ''<CR>
