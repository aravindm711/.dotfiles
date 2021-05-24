" {{{ nocompatible
if &compatible
    set nocompatible
endif
" }}}

" let mapleader be ' ', ffs.
let mapleader = ' '

" {{{ vim-plug

" vim-plug sets filetype plugin indent on | syntax on

" build YouCompleteMe engine after every update
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force " a:info.status == 'updated'
        !python3 install.py --all
    endif
endfunction

" plugins
call plug#begin('$HOME/.vim/plugged')

" git
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'

" looks
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" features
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'wesQ3/vim-windowswap'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'sotte/presenting.vim'

" files
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'justinmk/vim-dirvish'

" completion, linting, formatting
Plug 'sbdchd/neoformat'
Plug 'dense-analysis/ale'
Plug 'lifepillar/vim-mucomplete'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" snippets
Plug 'sirver/ultisnips'

" sessions
Plug 'tpope/vim-obsession'

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
set completeopt+=popup
set completeopt+=menuone,noselect

set vb t_vb=

" popup behaivour
set previewpopup=height:10,width:60,highlight:PMenuSbar
set completepopup=height:15,width:60,border:off,highlight:PMenuSbar

" empty character looks
set list
set listchars=tab:→\ ,trail:×,extends:>,precedes:<,space:·

" match angle brackets
set matchpairs+=<:>

" set autochdir                   " Change working directory to opened file

set tf                          " Fast terminal
set cursorline                  " Highlight the cursor line
set backspace=indent,eol,start  " Delete over line breaks
set binary                      " Enable binary support
set encoding=utf-8              " Use UTF-8 encoding
set hidden                      " Hide buffers instead of closing them
set nofoldenable                " Disable folding
set lazyredraw                  " Use lazy redrawing
set number                      " Show line numbers
set relativenumber              " Show relativeline numbers
set ruler                       " Show ruler
set showcmd                     " Show current command
set showmatch                   " Show matching bracket/parenthesis/etc
set showmode                    " Show current mode
set wildmenu
set wildmode=full

" Temp Files
set nobackup                    " No backup file
set noswapfile                  " No swap file
set nowritebackup               " No write backup

" Search
set incsearch                   " Incremental search
set hlsearch                    " Highlight matches
set ignorecase                  " Case-insensitive search...
set smartcase                   " ...unless search contains uppercase letter
set showmatch matchtime=3

" Indentation
set smarttab                    " Better tabs
set autoindent                  " Copy indentation from previous line
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

" Joining
set nojoinspaces                " Only one space when joining lines
set formatoptions+=j            " Remove comment leader when joining lines

" Mouse
set mousehide                   " Hide mouse when typing
set mouse=a                     " Enable mouse
set scrolloff=2                 " Keep at least 3 lines above/below

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
    set undofile                " Persistent undo
    set undodir=~/.vim/undo     " Location to store undo history
    set undolevels=1000         " Max number of changes
    set undoreload=10000        " Max lines to save for undo on a buffer reload
endif
" }}}

" {{{ plugin conf
" neoformat
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'args': ['-', '--line-length 119',],
            \ 'stdin': 1,
            \ }

let g:neoformat_try_formatprg = 1
let g:neoformat_enabled_python = ['black', 'isort', 'docformatter']
let g:neoformat_enabled_javascript = ['prettier']

" ycm
let g:ycm_auto_hover = ''
let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_global_extra_conf.py'

" let g:ycm_server_python_interpreter = '/usr/local/Cellar/python@3.8/3.8.5/bin/python3'

let g:ycm_filetype_whitelist = {
            \ 'c': 1,
            \ 'cs': 1,
            \ 'js': 1,
            \ 'ts': 1,
            \ 'cpp': 1,
            \ 'yaml': 1,
            \ 'python': 1,
            \ }

" ale
" let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
            \ 'python': ['pyflakes'],
            \ 'javascript': ['eslint'],
            \ }

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips']

" fuzzy file finder
command! BMDirs call fzf#run(fzf#wrap({
            \ 'source': 'cat $HOME/.cdbookmark | cut -d "|" -f 2',
            \ 'sink': 'FFFiles',
            \ }))

command! SessionRestore call fzf#run(fzf#wrap({
            \ 'source': 'ls $HOME/.vim/sessions | grep .vim | xargs -I {} -n 1 echo $HOME/.vim/sessions/{}',
            \ 'sink': function('SessionRestoreAndTrack'),
            \ }))

command! Dots call fzf#run(fzf#wrap({
            \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="$HOME/" "{print home \$0}"',
            \ 'sink': 'e',
            \ }))

let g:fzf_command_prefix = 'FF'
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" gruvbox
let g:gruvbox_contrast_dark='dark'
let g:gruvbox_invert_selection='0'
colo gruvbox

highlight clear Search
highlight Search ctermfg=233 ctermbg=109 cterm=bold
highlight IncSearch ctermfg=233 ctermbg=109 cterm=bold

" airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#dirvish#enabled = 1

" window-swap
let g:windowswap_map_keys = 0 " prevent default bindings

" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3
let g:netrw_browse_split=2
" }}}

" {{{ mappings
" {{{2 general mappings
nnoremap <M-Space> <Esc>

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

" open input file in horizontal split (cp)
nnoremap <leader>i<space> :split _input.txt \| resize 8<CR>

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
nnoremap <space>n<space> :Neoformat<CR>

" ycm
nmap <leader>yh <Plug>(YCMHover)

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

nnoremap <silent> <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yr :YcmCompleter RefactorRename<space>

" ale
nnoremap <silent> <leader>l :ALELint<CR>

" fuzzy file finder
nnoremap <leader>pp :FF
nnoremap <leader>pd :Dots<CR>
nnoremap <leader>po :BMDirs<CR>
nnoremap <leader>pf :FFFiles<CR>
nnoremap <leader>pa :FFLines<CR>
nnoremap <leader>pc :FFBLines<CR>
nnoremap <leader>pb :FFBuffers<CR>

" obsession
nnoremap <leader>sp :Obsession
nnoremap <leader>sr :SessionRestore<CR>
nnoremap <leader>ss :Obsession ~/.vim/sessions/<C-D>

" window-swap
nnoremap <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" mu-complete
nnoremap <leader>mu :MUcompleteAutoToggle<CR>

" undotree
nnoremap <leader>ut :UndotreeToggle<CR>
" }}}2
" }}}

" {{{ autocmds
" track session if detected, on entering
augroup TrackSession
    autocmd!
    autocmd VimEnter * :call CheckIfSession()
augroup END

" autostart mu-complete only for ycm-whitelisted ft
augroup AutoStartMUcomplete
    autocmd!
    autocmd FileType * if index(keys(g:ycm_filetype_whitelist), &ft) < 0 | silent execute 'MUcompleteAutoToggle'
augroup END

" autosave and autoload folds
augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave .vimrc,.zshrc mkview
    autocmd BufWinEnter .vimrc,.zshrc silent loadview
augroup END
" }}}
