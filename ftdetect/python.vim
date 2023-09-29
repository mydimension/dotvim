let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

let g:ale_python_pylint_options = '--min-similarity-lines=0'
let b:ale_fixers = ['isort', 'autoimport']
let b:ale_fix_on_save = 1

if ale#python#PoetryPresent(expand('%'))
    let s:venv = trim(system('poetry env info --path'))
    let $PATH = s:venv . '/bin:' . $PATH
endif
