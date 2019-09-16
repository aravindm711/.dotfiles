" tips
" use :retab to convert all the tabs to spaces

" vim-plug stuff
if !empty(glob("~/.vim/autoload/plug.vim"))
        call plug#begin('~/.vim/plugged')
        Plug 'tpope/vim-commentary'
        Plug 'bling/vim-airline'
        Plug 'airblade/vim-gitgutter'
        Plug 'terryma/vim-multiple-cursors'
        Plug 'tpope/vim-surround'
"        Plug 'Valloric/YouCompleteMe'
        Plug 'junegunn/fzf.vim'
        Plug 'scrooloose/nerdtree'
        Plug 'cocopon/iceberg.vim'
        Plug 'tomasiser/vim-code-dark'
        Plug 'jeffkreeftmeijer/vim-numbertoggle'
        call plug#end()
endif

" function to set all the plugin specific options
function SetPluginOptions()

        " ycm conf
        if &rtp =~ 'YouCompleteMe'
                let g:ycm_global_ycm_extra_conf = '~/.vim/conf-files/.ycm_extra_conf.py'
        endif

        " fzf conf
        if &rtp =~ 'fzf'
                set rtp+=/usr/local/opt/fzf
        endif
        
        " nerdtree conf
        if &rtp =~ 'nerdtree'
                map <C-t> :NERDTreeToggle<CR>
                nmap <leader>r :NERDTreeRefreshRoot
        endif
        
        if !empty(glob("~/.vim/plugged/vim-code-dark"))
                let g:airline_theme = 'codedark'
        endif

endfunction

call SetPluginOptions()

" color scheme
if !empty(glob("~/.vim/plugged/iceberg.vim"))
    colo iceberg
else
    colo industry
endif

" general conf

map <M-Space> <Esc>

map <C-l> :w<CR>
map <C-e> :wq<CR>

let mapleader = ","

noremap <leader>y "+y
noremap <leader>p "+p

filetype plugin indent on

syntax enable

set tf                          " Fast terminal
set cursorline                  " Highlight the cursor line
set backspace=indent,eol,start  " Delete over line breaks
set binary                      " Enable binary support
set encoding=utf-8              " Use UTF-8 encoding
set hidden                      " Hide buffers instead of closing them
set nofoldenable                " Disable folding
set lazyredraw                  " Use lazy redrawing
set number                      " Show line numbers
set ruler                       " Show ruler
set showcmd                     " Show current command
set showmatch                   " Show matching bracket/parenthesis/etc
set showmode                    " Show current mode
set wildmenu

" Temp Files
set nobackup                    " No backup file
set noswapfile                  " No swap file

" Search
set incsearch                   " Incremental search
set hlsearch                    " Highlight matches
set ignorecase                  " Case-insensitive search...
set smartcase                   " ...unless search contains uppercase letter

" Indentation
set smarttab                    " Better tabs
set autoindent                  " Copy indentation from previous line
set smartindent                 " Add indentation level
set tabstop=4                   " Columns a tab counts for
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

" Joining
set nojoinspaces                " Only one space when joining lines
set formatoptions+=j            " Remove comment leader when joining lines

set scrolloff=3                 " Keep at least 3 lines above/below

" Mouse
set mousehide                   " Hide mouse when typing
set mouse=a                     " Enable mouse

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

