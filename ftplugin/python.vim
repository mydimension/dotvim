let g:ale_python_pylint_options = '--min-similarity-lines=0'
let b:ale_fixers = ['isort', 'autoimport']
let b:ale_fix_on_save = 1

if ale#python#PoetryPresent(expand('%'))
    let s:venv = trim(system('poetry env info --path'))
    let $PATH = s:venv . '/bin:' . $PATH
endif

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>
