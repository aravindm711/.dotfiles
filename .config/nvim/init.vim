" let mapleader be ' ', ffs.
let mapleader = ' '

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" {{{ vim-plug

" vim-plug sets filetype plugin indent on | syntax on

" plugins
call plug#begin('~/.local/share/nvim/plugged')

    " features
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'wesQ3/vim-windowswap'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    " files
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " completion, linting, formatting
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sbdchd/neoformat'

    " sessions
    Plug 'tpope/vim-obsession'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'

    " looks
    Plug 'sheerun/vim-polyglot'
    Plug 'cocopon/iceberg.vim'
    Plug 'gkeep/iceberg-dark'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'mhinz/vim-startify'

call plug#end()
" }}}

" {{{ 'set'tings
" color settings
set t_ut=
set t_Co=256
set background=dark

" use number column for signs
" set signcolumn=number

" completion behaviour
set noinfercase
set shortmess+=c
set belloff+=ctrlg
set completeopt+=menuone,noselect

set vb t_vb=

" empty character looks
set list
set listchars=tab:→\ ,trail:×,extends:>,precedes:<,space:·

" match angle brackets
set matchpairs+=<:>

" set autochdir                   " Change working directory to opened file

set cursorline                  " Highlight the cursor line
set binary                      " Enable binary support
set nofoldenable                " Disable folding
set lazyredraw                  " Use lazy redrawing
set number                      " Show line numbers
set relativenumber              " Show relativeline numbers
set showmatch                   " Show matching bracket/parenthesis/etc
set showmode                    " Show current mode
set wildmode=full

" Temp Files
set nobackup                    " No backup file
set noswapfile                  " No swap file
set nowritebackup               " No write backup

" Search
set ignorecase                  " Case-insensitive search...
set smartcase                   " ...unless search contains uppercase letter
set showmatch matchtime=3

" Indentation
set tabstop=8                   " Columns a tab counts for
set softtabstop=4               " Columns a tab inserts in insert mode
set shiftwidth=4                " Columns inserted with the reindent operations
set shiftround                  " Always indent by multiple of shiftwidth
set expandtab                   " Always use spaces instead of tabs

" Key sequence timeout
set ttimeout                    " Enable time out
set ttimeoutlen=0               " Disable key code delay

" Wrapping
set nowrap                      " Don't wrap long lines
set linebreak                   " When wrapping, only at certain characters
set textwidth=0                 " Turn off physical line wrapping
set wrapmargin=0                " Turn off physical line wrapping
set colorcolumn=+1

" Mouse
set mousehide                   " Hide mouse when typing
set mouse=a                     " Enable mouse
set scrolloff=3                 " Keep at least 3 lines above/below

" Disable bell
set visualbell                  " Disable visual bell
set noerrorbells                " Disable error bell

" Splits
set splitbelow                  " Horizontal split below
set splitright                  " Vertical split right

" Spell checking
set spelllang=en_us             " English as default language
set nospell                     " Enable by default

" History
set history=1000                " Remember more commands
if has('persistent_undo')
    set undofile                      " Persistent undo
    set undolevels=1000               " Max number of changes
    set undoreload=10000              " Max lines to save for undo on a buffer reload
endif
" }}}

" {{{ plugin conf
" neoformat
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'args': ['-', '--line-length 79',],
            \ 'stdin': 1,
            \ }

let g:neoformat_try_formatprg = 1
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_javascript = ['prettier']

" startify
let g:startify_session_dir = '~/.local/share/nvim/sessions/'
let g:startify_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

" fuzzy file finder
command! BMDirs call fzf#run(fzf#wrap({
            \ 'source': 'cat $HOME/.cdbookmark | cut -d "|" -f 2',
            \ 'sink': 'FFFiles',
            \ }))

command! SessionRestore call fzf#run(fzf#wrap({
            \ 'source': 'ls ~/.local/share/nvim/sessions | grep .vim | xargs -I {} -n 1 echo ~/.local/share/nvim/sessions/{}',
            \ 'sink': function('SessionRestoreAndTrack'),
            \ }))

let g:fzf_command_prefix = 'FF'
let g:fzf_layout = {
            \ 'window': {
                \ 'width': 0.9,
                \ 'height': 0.8,
                \ 'border': 'rounded',
            \ }}
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Normal'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" iceberg
colo iceberg
hi Comment cterm=italic

" airline
let g:airline_theme='icebergDark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#dirvish#enabled = 1

" windowswap
let g:windowswap_map_keys = 0

" {{{ mappings
" {{{2 general mappings

" quit mappings
nnoremap <leader>e<space> :q!<CR>

" easy copy to system clipboard
vnoremap <leader>y<space> "+y
nnoremap <leader>p<space> "+p

" insert bracket pair
inoremap {, {}<left>
inoremap (, ()<left>
inoremap [, []<left>
inoremap <, <><left>

" visual mode
vnoremap > >gv
vnoremap < <gv

" split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" open alternate file
nnoremap <leader>a <C-^>

" display session name
nnoremap <leader>sn :echo v:this_session<CR>

" clear highlights
nnoremap <silent> <leader>c<space> :nohlsearch<CR>

" copy current directory path to system clipboard
nnoremap <leader>yd :call setreg("*", expand("%:p:h")) \| echo 'path copied to system clipboard'<CR>

" faster scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" sibling of J, to split line at the cursor
nnoremap S :<C-u>call BreakHere()<CR>

" on enter, insert selection if popup is visible or insert newline
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" insert indented newline
inoremap <expr> .<CR> InsertMapForEnter()
" }}}2

" {{{2  plugin mappings
" neoformat
nnoremap <space>n<space> <cmd>Neoformat<CR>

" fuzzy file finder
nnoremap <leader>pp :FF
nnoremap <leader>po <cmd>BMDirs<CR>
nnoremap <leader>pf <cmd>FFFiles<CR>
nnoremap <leader>pa <cmd>FFLines<CR>
nnoremap <leader>pc <cmd>FFBLines<CR>
nnoremap <leader>pb <cmd>FFBuffers<CR>
nnoremap <leader>pm <cmd>FFMarks<CR>
nnoremap <leader>pr <cmd>FFRg<CR>

" session obsession
nnoremap <leader>sr <cmd>SessionRestore<CR>
nnoremap <leader>sp :Obsession
nnoremap <leader>ss :Obsession ~/.local/share/nvim/sessions/

" window-swap
nnoremap <leader>yw <cmd>call WindowSwap#MarkWindowSwap()<CR>
nnoremap <leader>pw <cmd>call WindowSwap#DoWindowSwap()<CR>
nnoremap <leader>ww <cmd>call WindowSwap#EasyWindowSwap()<CR>

" undotree
nnoremap <leader>ut <cmd>UndotreeToggle<CR>

" coc
inoremap <silent><expr> <c-@> coc#refresh()

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" }}}2
" }}}

" {{{
" track session if detected, on entering
augroup TrackSession
    autocmd!
    autocmd VimEnter * :call CheckIfSession()
augroup END

" coc autocmds
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}
