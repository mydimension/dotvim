let g:ale_python_pylint_options = '--min-similarity-lines=0'

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>
