" let mapleader be ' ', ffs.
let mapleader = ' '

" build YouCompleteMe engine after every update
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
        !python3 install.py --all
    endif
endfunction

" vim-plug plugins
if !empty(glob("$HOME/.vim/autoload/plug.vim"))
    call plug#begin('$HOME/.vim/plugged')

    " tpope plugins
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'

    " looks
    Plug 'morhetz/gruvbox'
    Plug 'bling/vim-airline'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'

    " behaviour
    Plug 'wesQ3/vim-windowswap'

    " files
    Plug 'junegunn/fzf.vim'

    " completion and linting
    Plug 'dense-analysis/ale'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

    " snippets
    Plug 'sirver/ultisnips'

    " interesting
    Plug 'itchyny/calendar.vim'

    call plug#end()
endif

" insert indented newline if surrounded by brackets
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

" get list of loaded buffers
function GetLoadedBuffers()
    let g:bufflist = []
    for bufinfo in getbufinfo()
        let g:bufflist += [bufinfo.name]
    endfor
endfunction

" delete list of previously loaded buffers
function DeletePrevSessionBuffers()
    for buffername in g:bufflist
        if bufexists(buffername)
            silent execute 'bwipeout ' . buffername
        endif
    endfor
endfunction

" start obsession while restoring a session
function SessionRestoreAndTrack(session)
    redraw
    if v:this_session == a:session
        echo 'selected session is already open'
    else
        silent execute 'wa'
        call GetLoadedBuffers()
        silent execute 'source ' . a:session
        call DeletePrevSessionBuffers()
        execute 'Obsession ' . a:session
    endif
endfunction

" obsess if session is detected, on entering vim
function CheckIfSession()
    if v:this_session != ''
        let choice=input('session detected, do you want to start tracking [y/n]: ')
        if choice == 'y'
            execute 'Obsession ' . v:this_session
        endif
    endif
endfunction

" break line at the cursor
function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction

" plugin specific settings
function SetPluginOptions()

    " ycm conf
    if &rtp =~ 'YouCompleteMe'
        let g:ycm_global_ycm_extra_conf = $HOME.'/.vim/.ycm_extra_conf.py'
        " let g:ycm_server_python_interpreter = '/usr/local/opt/python@3.8/bin/python3'

        let g:ycm_show_diagnostics_ui = 0
        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1

        let g:ycm_filetype_whitelist = {
                                \ 'c': 1,
                                \ 'cs': 1,
                                \ 'js': 1,
                                \ 'ts': 1,
                                \ 'cpp': 1,
                                \ 'python': 1,
                                \ }

        let g:ycm_auto_hover = ''
        nmap <leader>yh <Plug>(YCMHover)

        nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
        nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

        nnoremap <silent> <leader>yf :YcmCompleter FixIt<CR>
        nnoremap <leader>yr :YcmCompleter RefactorRename<space>
    endif

    if &rtp =~ 'ale'
        let g:ale_linters = {
                    \ 'python': ['pyflakes'],
                    \ }
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_insert_leave = 0
        " let g:ale_lint_on_enter = 0

        highlight clear ALEErrorSign
        highlight clear ALEWarningSign

        nnoremap <silent> <leader>l :ALELint<CR>
    endif

    if &rtp =~ 'ultisnips'
        let g:UltiSnipsExpandTrigger="<C-s>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"

        let g:UltiSnipsEditSplit="vertical"
        let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips']
    endif

    " fuzzy file finder conf
    if &rtp =~ 'fzf'
        set rtp+=/usr/local/opt/fzf

        command! Dots call fzf#run(fzf#wrap({
                    \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="$HOME/" "{print home \$0}"',
                    \ 'sink': 'e',
                    \ }))

        command! BMDirs call fzf#run(fzf#wrap({
                    \ 'source': 'cat $HOME/.cdbookmark | cut -d "|" -f 2',
                    \ 'sink': 'FFFiles',
                    \ }))

        command! SessionRestore call fzf#run(fzf#wrap({
                    \ 'source': 'ls $HOME/.vim/sessions | grep .vim | xargs -I {} -n 1 echo $HOME/.vim/sessions/{}',
                    \ 'sink': function('SessionRestoreAndTrack'),
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

        nnoremap <leader>pp :FF
        nnoremap <leader>pd :Dots<CR>
        nnoremap <leader>po :BMDirs<CR>
        nnoremap <leader>pf :FFFiles<CR>
        nnoremap <leader>ps :FFLines<CR>
        nnoremap <leader>pb :FFBuffers<CR>
    endif

    if &rtp =~ 'gruvbox'
        let g:gruvbox_contrast_dark='dark'
        let g:gruvbox_invert_selection='0'
        colo gruvbox

        highlight Search cterm=undercurl ctermfg=225

        let g:airline_theme='gruvbox'
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled = 1
    endif

    if &rtp =~ 'obsession'
        augroup trackSession
            autocmd!
            autocmd VimEnter * :call CheckIfSession()
        augroup END

        nnoremap <leader>sr :SessionRestore<CR>
        nnoremap <leader>ss :Obsession ~/.vim/sessions/<C-D>
        nnoremap <leader>sp :Obsession
    endif

    if &rtp =~ 'vim-windowswap'
        let g:windowswap_map_keys = 0 " prevent default bindings
        nnoremap <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
        nnoremap <leader>pw :call WindowSwap#DoWindowSwap()<CR>
        nnoremap <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
    endif

    if &rtp =~ 'vim-mucomplete'
        let g:blacklist = ['c', 'cpp', 'cs', 'js', 'ts', 'py']
        augroup StartMUcomplete
            autocmd!
            autocmd FileType * if index(g:blacklist, &ft) < 0 | silent execute 'MUcompleteAutoToggle'
        augroup END

        nnoremap <leader>mu :MUcompleteAutoToggle<CR>
    endif

endfunction

" netrw conf
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3
let g:netrw_browse_split=2

" general conf
nnoremap <M-Space> <Esc>

" quit mappings
nnoremap <leader>e<space> :q!<CR>

" easy copy to system clipboard
vnoremap <leader>y<space> "*y
nnoremap <leader>p<space> "*p

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

" session conf
nnoremap <leader>sr :source ~/.vim/sessions/<C-D>
nnoremap <leader>ss :mksession! ~/.vim/sessions/<C-D>
nnoremap <leader>sn :echo v:this_session<CR>

" clear highlights
nnoremap <silent> <leader>c<space> :nohlsearch<CR>

" copy current directory path to system clipboard
nnoremap <leader>yd :call setreg("*", getcwd()) \| echo 'path copied to system clipboard'<CR>

" open input file in horizontal split (cp)
nnoremap <leader>i<space> :split _input.txt \| resize 8<CR>

" on enter, insert selection if popup is visible or insert newline
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" sibling of J, to split line at the cursor
nnoremap S :<C-u>call BreakHere()<CR>

" of course these both are on
syntax on
filetype plugin indent on

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

call SetPluginOptions()
