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

let mapleader = ' '

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    !./install.py --all
  endif
endfunction

" vim-plug stuff
if !empty(glob("$HOME/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/fzf.vim'
    Plug 'sirver/ultisnips'
    Plug 'bling/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'wesQ3/vim-windowswap'
    Plug 'airblade/vim-gitgutter'
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'itchyny/calendar.vim'
    Plug 'lifepillar/vim-mucomplete'
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'tpope/vim-surround'
    " Plug 'shime/vim-livedown'
    " Plug 'tpope/vim-commentary'
    " Plug 'gabrielelana/vim-markdown'
    call plug#end()
endif

function NERDTreeYankNode()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        call setreg('*', n.path.str())
    endif
endfunction

function YankFromCDBookmark()
    let i = 0
    let g:bookmarksList = {}
    " let bookmarkStrings = readfile(g:NERDTreeBookmarksFile)
    let bookmarkStrings = readfile("/Users/aravindmurali/.cdbookmark")
    for bookmark in bookmarkStrings
        if bookmark !=# ''
            let path = split(bookmark, '|')[1]
            " let path = substitute(bookmark, '^.\{-} \(.*\)$', '\1', '')
            let si = string(i)
            call extend(g:bookmarksList, {si : path})
            echo i . ' : ' . path
            let i += 1
        endif
    endfor

    let index = input('enter dir index : ')
    redraw
    if has_key(g:bookmarksList, index)
        call setreg('*', g:bookmarksList[index])
        execute 'FFFiles ' . g:bookmarksList[index]
    else
        echo 'invalid dir index'
    endif
endfunction

function InsertMapForEnter()
    if pumvisible()
        return "\<C-y>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == ')'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == ']'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

function GetLoadedBuffers()
    let g:bufflist = []
    for bufinfo in getbufinfo()
        let g:bufflist += [bufinfo.name]
    endfor
endfunction

function DeletePrevSessionBuffers()
    for buffername in g:bufflist
        if bufexists(buffername)
            execute 'bwipeout ' . buffername
        endif
    endfor
endfunction

function SessionRestoreAndTrack()
    let i = 0
    let sessionsList = split(globpath('$HOME/.vim/sessions/', '*'), '\n')
    for session in sessionsList
        echo i . ' : ' . split(session, '/')[-1]
        let i += 1
    endfor

    let index = input('enter session index : ')
    redraw
    if index < len(sessionsList)
        let session = sessionsList[index]
        if v:this_session == session
            echo 'selected session is already open'
        else
            execute 'wa'
            call GetLoadedBuffers()
            execute 'source ' . session
            call DeletePrevSessionBuffers()
            execute 'Obsession ' . session
        endif
    else
        echo 'invalid session index'
    endif
endfunction

" plugin specific settings
function SetPluginOptions()

    if &rtp =~ 'YouCompleteMe'
        " let g:ycm_global_ycm_extra_conf = '$HOME/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
        let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
        let g:ycm_python_binary_path = '/usr/local/bin/python3'
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
                    \ "cs":1,
                    \ "sh":1,
                    \ "cpp":1,
                    \ "zsh":1,
                    \ "objc":1,
                    \ "python":1
                    \ }

        nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
        nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
    endif

"     if &rtp =~ 'livedown'
"         " should markdown preview get shown automatically upon opening markdown buffer
"         let g:livedown_autorun = 0
"         " should the browser window pop-up upon previewing
"         let g:livedown_open = 1
"         n server will run
"         let g:livedown_port = 1337
"         " the browser to use, can also be firefox, chrome or other, depending on your executable
"         let g:livedown_browser = "firefox"
"
"         nnoremap mp :LivedownPreview<CR>
"         nnoremap mpk :LivedownKill<CR>
"         nnoremap mpt :LivedownToggle<CR>
"     endif

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
        let g:NERDTreeHighlightCursorline = 0
        let g:NERDTreeMinimalUI = 1
        let g:NERDTreeQuitOnOpen = 0
        let g:NERDTreeShowBookmarks = 1
        let g:NERDTreeShowFiles = 1
        let g:NERDTreeShowHidden = 1
        let g:NERDTreeIndicatorMapCustom = {
        \ 'Modified'  : '~',
        \ 'Staged'    : '▲',
        \ 'Untracked' : '+',
        \ 'Renamed'   : '→',
        \ 'Unmerged'  : '=',
        \ 'Deleted'   : '_',
        \ 'Dirty'     : '~',
        \ 'Clean'     : '◆',
        \ 'Unknown'   : '?'
        \ }

        nnoremap <leader>t<Space> :NERDTree<Space>
        nnoremap <leader>tf :NERDTreeFocus<CR>
        nnoremap <leader>tt :NERDTreeToggle<CR>
        nnoremap <leader>tb :NERDTreeFromBookmark<space>
        nnoremap <leader>ty :call NERDTreeYankNode()<CR> :NERDTreeClose<CR>

        autocmd bufenter * if (winnr("$") == 1  && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    endif

    if &rtp =~ 'fzf'
        set rtp+=/usr/local/opt/fzf

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

        nnoremap <leader>fd :Dots<CR>
        nnoremap <leader>f<space> :FF
        nnoremap <leader>ff :FFFiles<CR>
        nnoremap <leader>fi :FFLines<CR>
        nnoremap <leader>fl :FFBuffers<CR>
        nnoremap <leader>fy :call YankFromCDBookmark()<CR>
    endif
    
    if &rtp =~ 'gruvbox'
        let g:gruvbox_contrast_dark='dark'
        colo gruvbox

        let g:airline_theme='gruvbox'
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled = 1
    endif

    if &rtp =~ 'obsession'
        nnoremap <leader>sr :call SessionRestoreAndTrack()<CR>
        nnoremap <leader>ss :Obsession ~/.vim/sessions/<C-D>
        nnoremap <leader>sp :Obsession<CR>
        nnoremap <leader>sd :Obsession!<CR>
    endif

    if &rtp =~ 'vim-windowswap'
        let g:windowswap_map_keys = 0 "prevent default bindings
        nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
        nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
        nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
    endif

    if &rtp =~ 'vim-mucomplete'
        set noinfercase
        set completeopt+=menuone,noselect
        set completeopt-=preview
        set shortmess+=c
        set belloff+=ctrlg

        let g:mucomplete#enable_auto_at_startup = 1
    endif

endfunction

function CheckIfSession()
    if v:this_session != ''
        let choice=input('session detected, do you want to start tracking [y/n]: ')
        if choice == 'y'
            execute 'Obsession ' . v:this_session
        endif
    endif
endfunction


" netrw conf
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=2
let g:netrw_altv=1
let g:netrw_winsize=20

" general conf
noremap - $
noremap _ ^

nnoremap <M-Space> <Esc>

nnoremap <leader>. @:
nnoremap \rc :e ~/.vimrc<CR>
nnoremap \rl :so $MYVIMRC<CR>

nnoremap <CR> :wa<CR>
nnoremap <C-e> :wq<CR>
nnoremap <leader>e :q!<CR>
nnoremap <leader>s<space> :w<CR>

nnoremap Y 0y$
vnoremap <leader>y<space> "*y
nnoremap <leader>p<space> "*p
nnoremap <leader>P<space> "*P

nnoremap <leader>c<space> :noh<CR>
nnoremap <leader>cd :call setreg("*", getcwd())<CR>

inoremap {, {}<esc>i
inoremap (, ()<esc>i
inoremap [, []<esc>i
inoremap <, <><esc>i
inoremap <expr> .<CR> InsertMapForEnter()

" Split Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Session Mappings
nnoremap <leader>sr :source ~/.vim/sessions/<C-D>
nnoremap <leader>ss :mksession! ~/.vim/sessions/<C-D>
nnoremap <leader>sn :echo v:this_session<CR>

augroup opensession
    autocmd!
    autocmd VimEnter * :call CheckIfSession()
augroup END

" augroup completionengine
"     autocmd!
"     autocmd VimEnter * :call CheckIfSession()
" augroup END

" Open Input file in horizontal split ( for cp )
nnoremap <leader>i<space> :split _input.txt<CR> :resize 8<CR>

" tab and enter behaviour
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Abbreviations
iabbrev @g aravindmurali711@gmail.com
iabbrev @y aravindmurali711@yahoo.com

filetype plugin indent on

syntax on

" color scheme settings
set background=dark
set t_Co=256
set t_ut=

" set langmap=soSOdeDEedEDfuFUgiGIhdHDjhJHktKTlnLN\;s\:S'-"_q'Q"w\,W<e.E>rpRPtyTYyfYFugUGicICorORpLpL[/{?]=}+z\;Z\:xqXQcjCJvkVKbxBXnbNB\,w<W.v>V/z?Z

set previewpopup=height:10,width:60,highlight:PMenuSbar
set completeopt+=popup
set completepopup=height:15,width:60,border:off,highlight:PMenuSbar

set list
set listchars=tab:→\ ,trail:×,extends:>,precedes:<,space:·

set autochdir                   " Change working directory to opened file

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
" set hlsearch                    " Highlight matches
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

call SetPluginOptions()
