" Fast folding by indent
setlocal foldmethod=indent

" Comment current line
nnoremap <buffer> <localleader>c I#<ESC>

" Quick file access in virtualenvs (should only load for Python files)
nnoremap <leader>vp :e $VIRTUAL_ENV/lib/python3.6/site-packages/

" Shortcut to insert pdb
inoremap <C-J> import ipdb; ipdb.set_trace() 

" Map K to use taglist (keyword lookup)
nnoremap <buffer> K <C-]>

