set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" For fresh setup:
"   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   vim +PluginInstall +qall

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'bitc/vim-bad-whitespace'
Plugin 'mantiz/vim-plugin-dirsettings'
Plugin 'tpope/vim-fugitive'
Plugin 'othree/html5-syntax.vim'
Plugin 'bokutin/mason2.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-signify'
" Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'wellle/targets.vim'
Plugin 'wincent/terminus'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'vim-perl/vim-perl'
Plugin 'edkolev/promptline.vim'
Plugin 'derekwyatt/vim-sbt'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-surround'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'vimwiki/vimwiki'

call vundle#end()
filetype plugin indent on

silent! call dirsettings#Install()

syntax on
syntax enable
set backspace=indent,eol,start
set autoindent
"set smartindent
set copyindent
set smarttab
set expandtab     " spaces instead of tabs
set tabstop=4     " width of a real tab, or no. spaces inserted
set softtabstop=4 " backspace will go back this many spaces
set shiftwidth=4  " tab operations will got this far
set shiftround
set showmatch
set incsearch
set ignorecase
set smartcase
set hlsearch
set history=1000
set undolevels=1000
set directory=~/.vim/tmp
set title
set nobackup
set scrolloff=5
set backupskip=/tmp/*,/var/tmp/*,/private/tmp/*
set encoding=utf-8
set wildmenu
set wildmode=list:longest
set ttyfast
set laststatus=2
set cursorline
set relativenumber
set colorcolumn=80
"set noesckeys
"set ttimeoutlen=100
set noshowmode

" force 256 colors, regardless of $TERM
set t_Co=256

set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" easier to type than /
let mapleader = ','

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" For smart TAB completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

let g:signify_vcs_list = ['git', 'hg', 'svn', 'bzr']

let g:airline#extensions#tmuxline#snapshot_file   = '~/dotfiles/tmuxline.conf'
let g:airline#extensions#promptline#snapshot_file = '~/dotfiles/promptline.sh'
let g:airline#extensions#hunks#non_zero_only      = 1
let g:airline#extensions#tabline#enabled          = 1
let g:airline#extensions#tabline#show_buffers     = 1

let g:airline_powerline_fonts = 1
let g:airline_theme           = 'powerlineish'

let g:promptline_theme   = 'airline'
let g:promptline_symbols = { 'dir_sep': '/' }
let g:promptline_preset  = {
    \'a':    [ promptline#slices#python_virtualenv(), promptline#slices#host() ],
    \'b':    [ promptline#slices#user() ],
    \'c':    [ promptline#slices#cwd(), promptline#slices#jobs() ],
    \'y':    [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
    \'z':    [ '$([[ -n ${ZSH_VERSION:-} ]] && print %D\{%m/%d %H:%M:%S\} || printf "%s" \\D{%H:%M:%S})' ],
    \'warn': [ promptline#slices#last_exit_code() ] }

let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
    \'a':           [ '#S' ],
    \'c':           [ '#I.#P' ],
    \'y':           [ '%Y-%m-%d', '%H:%M:%S' ],
    \'z':           [ '#h' ],
    \'win':         [ '#I#F', '#W' ],
    \'cwin':        [ '#I', '#W' ],
    \'win_options': { 'window-status-activity-attr': 'bold' },
    \'options':     { 'status-justify': 'left', 'status-interval': '1' } }

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']

nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

let &path = '.,' . substitute($PATH, ':', ',', 'g')

" training wheel OFF
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

let NERDTreeHijackNetrw=1
let vitality_fix_focus=0
"let netrw_liststyle=3 " tree-mode
let netrw_browse_split=4 " open file in previous buffer
let netrw_preview=1 " preview window in vert-split

if v:version >= 700
    nmap <leader>l :set list!<CR>
    set listchars=tab:▸\ ,eol:¬
    set nospell
endif

if has('mouse')
    set mouse=a
    set ttymouse=xterm2
    if &term =~ "xterm" || &term =~ "screen"
        " for some reason, doing this directly with 'set ttymouse=xterm2'
        " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
        " makes tmux enter copy mode instead of selecting or scrolling
        " inside Vim -- but luckily, setting it up from within autocmds
        " works
        autocmd VimEnter    * set ttymouse=xterm2
        autocmd FocusGained * set ttymouse=xterm2
        autocmd BufEnter    * set ttymouse=xterm2
    endif
endif

" perltidy shortcut
nnoremap <silent> <leader>t :%!perltier -st -q<Enter>
vnoremap <silent> <leader>t :!perltier -st -q<Enter>

" perl syntax checking with warnings
map <leader>a :w !/usr/bin/env perl -cw 2>&1 \| more<cr>

" homerow Home & End
noremap H ^
noremap L g_

autocmd BufNewFile,BufRead *.html set ft=mason
autocmd BufNewFile,BufRead */autohandler set ft=mason

" save state of folds when we leave, and restore when we come back
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

autocmd BufEnter * :syntax sync fromstart

"Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" this is for MySQL's 'edit' command while in the client
autocmd! BufRead,BufNewFile /tmp/sql* set ft=sql
autocmd! BufRead,BufNewFile /tmp/psql* set ft=sql

autocmd FileType crontab set nobackup nowritebackup

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
