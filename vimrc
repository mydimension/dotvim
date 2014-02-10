let g:pathogen_disabled = []
if v:version == 700 && !has('patch167')
    call add(g:pathogen_disabled, 'tagbar')
endif

" make easy loading for future plugins
silent! call pathogen#infect()
silent! call pathogen#helptags()

"filetype plugin indent on

syntax on
syntax enable
set nocompatible
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
" set cursorline
set relativenumber
set colorcolumn=80
set noesckeys
set noshowmode

" force 256 colors, regardless of $TERM
set t_Co=256

set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" easier to type than /
let mapleader = ','

let g:signify_vcs_list = ['git', 'hg', 'svn', 'bzr']

let g:airline#extensions#tmuxline#snapshot_file = '~/dotfiles/tmuxline.conf'
let g:airline#extensions#hunks#non_zero_only    = 1
let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#show_buffers   = 0

let g:airline_powerline_fonts = 1
let g:airline_theme           = 'powerlineish'

let g:promptline_theme   = 'airline'
let g:promptline_symbols = { 'dir_sep': '/' }
let g:promptline_preset  = {
    \'a':    [ '$([[ -n "${VIRTUAL_ENV:-}" ]] && echo "(${VIRTUAL_ENV##*/})")', promptline#slices#host() ],
    \'b':    [ promptline#slices#user() ],
    \'c':    [ promptline#slices#cwd(), promptline#slices#jobs() ],
    \'y':    [ promptline#slices#vcs_branch() ],
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
nnoremap <silent> <leader>t :%!perltidy -st -q<Enter>
vnoremap <silent> <leader>t :!perltidy -st -q<Enter>

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
