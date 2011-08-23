filetype off

" make easy loading for future plugins
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

filetype plugin indent on

syntax on
syntax enable
set nocompatible
set backspace=2
set mouse=a
"set ttymouse=xterm2
set ttymouse=xterm
set autoindent
"set smartindent
set copyindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
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

if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

let NERDTreeShowHidden = 1

if v:version >= 700
	nmap <leader>l :set list!<CR>
	set listchars=tab:▸\ ,eol:¬
    set nospell
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
nnoremap <silent> <leader>t :%!perltidy -q<Enter>
vnoremap <silent> <leader>t :!perltidy -q<Enter>

" perl syntax checking with warnings
"map <leader>a :w !perl -cw 2>&1 \| more<CR>
noremap <buffer> <silent> <leader>a :call Perl_SyntaxCheck()<CR>

" convert line endings to unix format
nmap <leader>ux :se ff=unix<CR>

map cc zfa{

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
let perl_want_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1

let javaScript_fold=1

" this is for MySQL's 'edit' command while in the client
au! BufRead,BufNewFile /tmp/sql* set ft=sql
au! BufRead,BufNewFile /tmp/psql* set ft=sql

if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
