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
set backspace=2
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
set history=1000
set undolevels=1000
set directory=~/.vim/tmp
set title
set nobackup
set nohlsearch
set scrolloff=5
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

" force 256 colors, regardless of $TERM
set t_Co=256

colorscheme darkdevel
" colorscheme lucius

let NERDTreeShowHidden = 1
let g:vitality_fix_focus = 0

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

if has('cmdline_info')
	set ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
"	set rulerformat=%15(%c%V\ %p%%%) 
	set showcmd
endif

if has('statusline')
	set laststatus=2
"	set statusline=%<%f\ %=\:\b%n\[%{strlen(&ft)?&ft:'none'}/%{&encoding}/%{&fileformat}]%m%r%w\ %l,%c%V\ %P
	set statusline=%<%f%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%D\ %T\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ %P
endif

" highlights space characters at the end of lines to point them out
highlight RedundantSpaces ctermbg=blue guibg=blue
match RedundantSpaces /\s\+$\| \+\ze\t/

" perltidy shortcut
nnoremap <silent> <leader>t :%!perltidy -st -q<Enter>
vnoremap <silent> <leader>t :!perltidy -st -q<Enter>

" perl syntax checking with warnings
if executable('/opt/local/bin/perl')
    map <leader>a :w !/opt/local/bin/perl -cw 2>&1 \| more<CR>
else
    map <leader>a :w !perl -cw 2>&1 \| more<CR>
endif

" convert line endings to unix format
nmap <leader>ux :se ff=unix<CR>

map cc zfa{

noremap H ^
noremap L g_

au BufNewFile,BufRead *.html set ft=mason
au BufNewFile,BufRead *.cmp  set ft=mason
au BufNewFile,BufRead *.xmp  set ft=mason
au BufNewFile,BufRead */autohandler set ft=mason

" save state of folds when we leave, and restore when we come back
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

au BufEnter * :syntax sync fromstart

"Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

let perl_fold=1
let perl_fold_blocks=1
let perl_no_extended_vars=1

let javaScript_fold=1

" this is for MySQL's 'edit' command while in the client
au! BufRead,BufNewFile /tmp/sql* set ft=sql
au! BufRead,BufNewFile /tmp/psql* set ft=sql

au FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
au FileType java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
au FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
let g:EclimJavaSearchSingleResult='tabnew'

if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
