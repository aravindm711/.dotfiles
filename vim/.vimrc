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

let mapleader = ','

" vim-plug stuff
if !empty(glob("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    Plug 'bling/vim-airline'
    Plug 'cocopon/iceberg.vim'
    Plug 'gkeep/iceberg-dark'
    Plug 'Valloric/YouCompleteMe'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    Plug 'sirver/ultisnips'
    Plug 'junegunn/fzf.vim'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-obsession'
"        Plug 'mcchrish/nnn.vim'
"        Plug 'terryma/vim-multiple-cursors'
"        Plug 'tpope/vim-surround'
"        Plug 'shime/vim-livedown'
"        Plug 'tpope/vim-commentary'
"        Plug 'gabrielelana/vim-markdown'
    call plug#end()
endif

" function to set all the plugin specific options
function SetPluginOptions()

    " ycm conf
    if &rtp =~ 'YouCompleteMe'
        let g:ycm_global_ycm_extra_conf = '~/.vim/conf-files/.ycm_extra_conf.py'
        let g:ycm_server_python_interpreter = '/usr/bin/python3'
        let g:ycm_python_binary_path = '/usr/bin/python3'
        let g:syntastic_python_checkers=['pyflakes']

        let g:ycm_complete_in_comments=1
        let g:syntastic_error_symbol='>>'
        let g:syntastic_warning_symbol='>'
        let g:syntastic_check_on_open=1
        let g:syntastic_check_on_wq=0
        let g:syntastic_enable_highlighting=1

        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1

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

"     if &rtp =~ 'livedown'
"         " should markdown preview get shown automatically upon opening markdown buffer
"         let g:livedown_autorun = 0
"         " should the browser window pop-up upon previewing
"         let g:livedown_open = 1
"         n server will run
"         let g:livedown_port = 1337
"         " the browser to use, can also be firefox, chrome or other, depending on your executable
"         let g:livedown_browser = "safari"
" 
"         nnoremap mp :LivedownPreview<CR>
"         nnoremap mpk :LivedownKill<CR>
"         nnoremap mpt :LivedownToggle<CR>
"     endif

    " UltiSnips conf
    if &rtp =~ 'ultisnips'
        let g:UltiSnipsExpandTrigger="<C-c>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"

        let g:UltiSnipsEditSplit="vertical"
        let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/ultisnips']
    endif

    if &rtp =~ 'nerdtree'
        let g:NERDTreeWinPos = 'right'
        let g:NERDTreeShowBookmarks = 1

        nnoremap <leader>t<Space> :NERDTree<Space>
        nnoremap <leader>tf :NERDTreeFocus<CR>
        nnoremap <leader>tt :NERDTreeToggle<CR>
        nnoremap <leader>tc :NERDTreeClose<CR>

        autocmd bufenter * if (winnr("$") == 1  && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    endif

    if &rtp =~ 'fzf'
        set rtp+=/usr/local/opt/fzf
        nnoremap <leader>f<space> :Files<CR>
        nnoremap <leader>fl :Buffers<CR>
        nnoremap <leader>fc :Commands<CR>
        nnoremap <leader>fh :History<CR>
    endif

    if &rtp =~ 'iceberg'
        colo iceberg
    endif

    if &rtp =~ 'airline'
        let g:airline_theme = 'icebergDark'
        let g:airline_powerline_fonts = 1
    endif

    if &rtp =~ 'obsession'
        nnoremap <leader>ss :Obsession ~/.vim/sessions/<C-D>
        nnoremap <leader>sp :Obsession<CR>
        nnoremap <leader>sd :Obsession!<CR>
    endif

endfunction

" color scheme settings
set background=dark
set t_Co=256
set t_ut=

" netwr conf
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=2
let g:netrw_altv=1
let g:netrw_winsize=20

" general conf

nnoremap <M-Space> <Esc>

nnoremap <leader>s<space> :w<CR>
nnoremap <C-e> :wq<CR>
nnoremap <leader>e :q!<CR>

vnoremap <leader>y "*y
nnoremap <leader>p "*p

nnoremap <leader>c :noh<CR>

" Navigation Mappings

" Text Navigation
noremap <space> j
noremap - k

" Split Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-n> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Session Mappings
nnoremap <leader>sr :so ~/.vim/sessions/<C-D>
nnoremap <leader>ss :mksession! ~/.vim/sessions/<C-D>
nnoremap <leader>sn :echo v:this_session<CR>

" ---------------------------------------------------------------------------- "

" Open Input file in horizontal split
nnoremap <leader>i<space> :sp _input.txt<CR> :resize 8<CR>

call SetPluginOptions()

" Abbreviations
iabbrev @g aravindmurali711@gmail.com
iabbrev @y aravindmurali711@yahoo.com

filetype plugin indent on

syntax on

" set langmap=soSOdeDEfuFUgiGIhdHDjhJHktKTlnLN\;s\:S'-"_q'Q"w\,W<e.E>rpRPtyTYyfYFugUGicICorORpLpL[/{?]=}+z\;Z\:xqXQcjCJvkVKbxBXnbNB\,w<W.v>V/z?Z

set previewpopup=height:10,width:60,highlight:PMenuSbar
set completeopt+=popup
set completepopup=height:15,width:60,border:off,highlight:PMenuSbar

set autochdir                   " Change working directory to opened file

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:·

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
set textwidth=80                " Turn off physical line wrapping
set colorcolumn=+1
set wrapmargin=0                " Turn off physical line wrapping

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
