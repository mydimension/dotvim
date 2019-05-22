if exists('b:current_syntax')
  finish
endif

" Load Python syntax at the top level
runtime! syntax/python.vim
unlet b:current_syntax

" Load SQL syntax
syn include @SQL syntax/sql.vim

" We don't need these (a string inside a string!)
syn cluster SQL remove=sqlString

" Clear existing syntax
syntax clear pythonString

" Modify python.vim string syntax
syn region  pythonString
    \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
    \ contains=pythonEscape,@Spell
syn region  pythonString
    \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
    \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell,@SQL
syn region  pythonRawString
    \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
    \ contains=@Spell
syn region  pythonRawString
    \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
    \ contains=pythonSpaceError,pythonDoctest,@Spell,@SQL

let b:current_syntax = 'pysql'
