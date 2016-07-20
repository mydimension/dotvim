" perltidy shortcut
nnoremap <silent> <leader>t :%!perltidier -st -q<Enter>
vnoremap <silent> <leader>t :!perltidier -st -q<Enter>

" perl syntax checking with warnings
map <leader>a :w !/usr/bin/env perl -cw 2>&1 \| more<cr>
