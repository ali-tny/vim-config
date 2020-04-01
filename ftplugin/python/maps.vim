" Fast folding by indent
setlocal foldmethod=indent

" Comment current line
nnoremap <buffer> <localleader>c I#<ESC>

" Quick file access in virtualenvs
nnoremap <leader>vp :e $VIRTUAL_ENV/lib/python3.7/site-packages/

" Shortcut to insert debugger breakpoint.
inoremap <C-J> breakpoint()

" Map K to use taglist (keyword lookup)
nnoremap <buffer> K <C-]>

