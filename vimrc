" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/bundle')
    Plug 'maxmx03/solarized.nvim',           Cond(has('nvim'))
    Plug 'altercation/vim-colors-solarized', Cond(!has('nvim'))

    Plug 'bitc/vim-bad-whitespace'
    Plug 'bokutin/mason2.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dense-analysis/ale', Cond(!has('g:vscode'))
    Plug 'chaimleib/vim-renpy'
    Plug 'derekwyatt/vim-sbt'
    Plug 'derekwyatt/vim-scala'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'edkolev/promptline.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'hdima/python-syntax'
    Plug 'github/copilot.vim'
    Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'junegunn/vim-easy-align'
    Plug 'jvirtanen/vim-hcl'
    Plug 'lifepillar/pgsql.vim'
    Plug 'majutsushi/tagbar'
    Plug 'mantiz/vim-plugin-dirsettings'
    Plug 'mhinz/vim-signify'
    Plug 'motus/pig.vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'othree/html5-syntax.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'plasticboy/vim-markdown'
    Plug 'petobens/poet-v'
    Plug 'rhysd/vim-syntax-codeowners'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'towolf/vim-helm'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vimwiki/vimwiki'
    Plug 'wellle/targets.vim'
    Plug 'wincent/terminus'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'APZelos/blamer.nvim'
    Plug 'mustache/vim-mustache-handlebars'

    " dadbod
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
    Plug 'kristijanhusak/vim-dadbod-completion'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " disabled due to slowness
    Plug 'vim-perl/vim-perl', { 'branch': 'dev', 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny heredoc-sql' }
call plug#end()

filetype plugin indent on

silent! call dirsettings#Install()

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
set signcolumn=yes
set incsearch
set ignorecase
set smartcase
set hlsearch
set history=1000
set undolevels=1000
set directory=~/.vim/tmp
set title
set nobackup
set nowritebackup
set scrolloff=5
set backupskip=/tmp/*,/var/tmp/*,/private/tmp/*
set encoding=utf-8
set wildmenu
set wildmode=list:longest
set ttyfast
set laststatus=2
set cursorline
set number relativenumber
set colorcolumn=120
"set noesckeys
"set ttimeoutlen=100
set noshowmode
set splitbelow
set splitright
set updatetime=300

" force 256 colors, regardless of $TERM
set t_Co=256

set background=dark
let g:solarized_termtrans=1

if has('nvim')
    call v:lua.require('solarized').setup({'variant': 'summer'})
endif
colorscheme solarized
" endif

let &path = '.,' . substitute($PATH, ':', ',', 'g')

" easier to type than /
let mapleader = ','

let g:acp_enableAtStartup = 0

let g:coc_global_extensions = [
    \ 'coc-diagnostic',
    \ 'coc-docker',
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-perl',
    \ 'coc-jedi',
    \ 'coc-sql',
    \ 'coc-toml',
    \ 'coc-vimlsp',
    \ 'coc-yaml'
    \ ]

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
    \'a':    [ promptline#slices#python_virtualenv(), promptline#slices#host({ 'only_if_ssh': 1 }) ],
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
    \'options':     { 'status-justify': 'left', 'status-interval': '1' } }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']

let g:ale_open_list = 1
let g:ale_linters = { 'perl': ['perl', 'perlcritic'], }
"let g:ale_python_auto_pipenv = 1
let g:ale_perl_perlcritic_showrules = 1

function! _aleCloseWindowIfNotEmpty() abort
    if getbufvar(bufnr(''), '&buftype') ==# 'quickfix'
        return
    endif
    if g:ale_set_quickfix
        silent! cclose
    elseif g:ale_set_loclist
        silent! lclose
    endif
endfunction

autocmd QuitPre * call _aleCloseWindowIfNotEmpty()

let g:blamer_enabled = 1
let g:blamer_prefix = ' ❯ '
let g:blamer_date_format = '%Y-%m-%d %H:%M'
let g:blamer_show_in_visual_modes = 0
let g:GBlameVirtualTextEnable = 1
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

let g:python_highlight_all = 1

let NERDTreeHijackNetrw=1
let vitality_fix_focus=0
"let netrw_liststyle=3 " tree-mode
let netrw_browse_split=4 " open file in previous buffer
let netrw_preview=1 " preview window in vert-split

" dadbod (and other) config
let g:db_ui_use_nerd_fonts = 1
if has('nvim')
    let g:db_ui_use_nvim_notify = 1
endif
let g:db_ui_hide_schemas = ['pg_temp.*', 'pg_toast_temp.*']

nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

" training wheel OFF
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" j/k traverse screen lines and not logical lines
nnoremap j gj
nnoremap k gk

" homerow Home & End
noremap H ^
noremap L g_

" <CR>: close popup and save indent.
"" <cr> confirms completion
"inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
"" <cr> selects first item and confirms completion
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" <TAB>: completion.
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <expr><Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<s-tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if v:version >= 700
    nmap <leader>l :set list!<CR>
    set listchars=tab:▸\ ,eol:¬
    set nospell
endif

if has('mouse') && !has('nvim')
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

" save state of folds when we leave, and restore when we come back
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

autocmd BufEnter * :syntax sync fromstart

"Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
