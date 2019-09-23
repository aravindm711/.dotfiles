"
"
"                                    /$$                              
"                                   | $$                              
"      /$$  /$$  /$$  /$$$$$$       | $$  /$$$$$$  /$$    /$$ /$$$$$$ 
"     | $$ | $$ | $$ /$$__  $$      | $$ /$$__  $$|  $$  /$$//$$__  $$
"     | $$ | $$ | $$| $$$$$$$$      | $$| $$  \ $$ \  $$/$$/| $$$$$$$$
"     | $$ | $$ | $$| $$_____/      | $$| $$  | $$  \  $$$/ | $$_____/
"     |  $$$$$/$$$$/|  $$$$$$$      | $$|  $$$$$$/   \  $/  |  $$$$$$$
"      \_____/\___/  \_______/      |__/ \______/     \_/    \_______/
"     
"     
"                        ██╗   ██╗██╗███╗   ███╗
"                        ██║   ██║██║████╗ ████║
"                        ██║   ██║██║██╔████╔██║
"                        ╚██╗ ██╔╝██║██║╚██╔╝██║
"                         ╚████╔╝ ██║██║ ╚═╝ ██║
"                          ╚═══╝  ╚═╝╚═╝     ╚═╝
"
"
" shortcuts:
"
" use ':retab' to convert all the tabs to spaces
"
" use 'mp' for markdown preview ; 'mpk' to kill preview server ; 'mpt' to
" toggle preview server on or off
"
"

" vim-plug stuff
if !empty(glob("~/.vim/autoload/plug.vim"))
        call plug#begin('~/.vim/plugged')
        Plug 'tpope/vim-commentary'
        Plug 'bling/vim-airline'
        Plug 'airblade/vim-gitgutter'
        Plug 'terryma/vim-multiple-cursors'
        Plug 'tpope/vim-surround'
        Plug 'Valloric/YouCompleteMe'
        Plug 'junegunn/fzf.vim'
        Plug 'cocopon/iceberg.vim'
        Plug 'tomasiser/vim-code-dark'
        Plug 'jeffkreeftmeijer/vim-numbertoggle'
        Plug 'shime/vim-livedown'
        Plug 'gabrielelana/vim-markdown'
        Plug 'mcchrish/nnn.vim'
        call plug#end()
endif

" function to set all the plugin specific options
function SetPluginOptions()

        " ycm conf
        if &rtp =~ 'YouCompleteMe'
                let g:ycm_global_ycm_extra_conf = '~/.vim/conf-files/.ycm_extra_conf.py'

                let g:ycm_server_python_interpreter = '/usr/bin/python'
                let g:ycm_python_binary_path = '/usr/bin/python'
                let g:syntastic_python_checkers=['pyflakes']
                
                let g:ycm_complete_in_comments=1
                let g:syntastic_error_symbol='>>'
                let g:syntastic_warning_symbol='>'
                let g:syntastic_check_on_open=1
                let g:syntastic_check_on_wq=0
                let g:syntastic_enable_highlighting=1

                let g:ycm_filetype_whitelist = {
                            \ "c":1,
                            \ "cpp":1,
                            \ "objc":1,
                            \ "sh":1,
                            \ "zsh":1,
                            \ "python":1,
                            \ "vim":1
                            \ }
        endif

        " fzf conf
        if &rtp =~ 'fzf'
                set rtp+=/usr/local/opt/fzf
        endif

        " status-line plugin
        if !empty(glob("~/.vim/plugged/vim-code-dark"))
                let g:airline_theme = 'codedark'
        endif

        if &rtp =~ 'livedown'
            " should markdown preview get shown automatically upon opening markdown buffer
            let g:livedown_autorun = 0
            " should the browser window pop-up upon previewing
            let g:livedown_open = 1
            " the port on which Livedown server will run
            let g:livedown_port = 1337
            " the browser to use, can also be firefox, chrome or other, depending on your executable
            let g:livedown_browser = "chrome"

            nmap mp :LivedownPreview<CR>
            nmap mpk :LivedownKill<CR>
            nmap mpt :LivedownToggle<CR>
        endif

        if &rtp =~ 'nnn'
            let g:nnn#set_default_mappings=0
    
            nnoremap <silent> <leader>n :Np<CR>
            nnoremap <leader>nn :Np '%:p:h'<CR>

            let g:nnn#layout = { 'right': '~20%' }
            let g:nnn#action = {
                \ '<c-t>': 'tab split',
                \ '<c-x>': 'split',
                \ '<c-v>': 'vsplit'}
        endif

endfunction

" color scheme
if !empty(glob("~/.vim/plugged/iceberg.vim"))
    colo iceberg
else
    colo industry
endif

" netwr conf
let g:netwr_liststyle=3
let g:netwr_banner=0
let g:netwr_browse_split=2
let g:netwr_altv=1
let g:netwr_winsize=20

" general conf

let mapleader = ","

call SetPluginOptions()

noremap <M-Space> <Esc>

map <C-l> :w<CR>
map <C-e> :wq<CR>

noremap <leader>y "+y
noremap <leader>p "+p

nmap <leader>t <C-w>h
nmap <leader>s <C-w>l
nmap <leader>r <C-w>j
nmap <leader>v <C-w>k

filetype plugin indent on

syntax enable

" set langmap=soSOdeDEfuFUgiGIhdHDjhJHktKTlnLN\;s\:S'-"_q'Q"w\,W<e.E>rpRPtyTYyfYFugUGicICorORpLpL[/{?]=}+z\;Z\:xqXQcjCJvkVKbxBXnbNB\,w<W.v>V/z?Z

" set rn

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
