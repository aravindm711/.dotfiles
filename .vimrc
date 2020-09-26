" let mapleader be ' ', ffs.
let mapleader = ' '

" vim-plug

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins
call plug#begin('$HOME/.vim/plugged')

    " git
    Plug 'junegunn/gv.vim'
    Plug 'tpope/vim-fugitive'

    " looks
    Plug 'morhetz/gruvbox'
    Plug 'bling/vim-airline'
    Plug 'mhinz/vim-startify'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'

    " behaviour
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'

    " files
    Plug 'junegunn/fzf.vim'
    Plug 'justinmk/vim-dirvish'

    " completion and linting
    Plug 'lifepillar/vim-mucomplete'

call plug#end()

" 'set'tings
" color settings
set t_ut=
set t_Co=256
set background=dark

" completion behaviour
set noinfercase
set shortmess+=c
set belloff+=ctrlg
set completeopt+=popup
set completeopt+=menuone,noselect

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
    set undofile                " Persistent undo
    set undodir=~/.vim/undo     " Location to store undo history
    set undolevels=1000         " Max number of changes
    set undoreload=10000        " Max lines to save for undo on a buffer reload
endif

" plugin conf
" fuzzy file finder
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

" general conf
" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3
let g:netrw_browse_split=2

" mappings
" general mappings
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

" insert indented newline
inoremap <expr> .<CR> InsertMapForEnter()

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

" open input file in horizontal split (cp)
nnoremap <leader>i<space> :split _input.txt \| resize 8<CR>

" on enter, insert selection if popup is visible or insert newline
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" sibling of J, to split line at the cursor
nnoremap S :<C-u>call BreakHere()<CR>

" plugin mappings
" fuzzy file finder
nnoremap <leader>pp :FF
nnoremap <leader>pd :Dots<CR>
nnoremap <leader>pf :FFFiles<CR>
nnoremap <leader>pa :FFLines<CR>
nnoremap <leader>pc :FFBLines<CR>
nnoremap <leader>pb :FFBuffers<CR>

" mu-complete
nnoremap <leader>mu :MUcompleteAutoToggle<CR>

" autocmds
" autosave folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave .vimrc,.zshrc mkview
  autocmd BufWinEnter .vimrc,.zshrc silent loadview
augroup END

