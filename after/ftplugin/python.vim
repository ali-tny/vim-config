setlocal filetype=python.django 

" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Delete trailing whitespace when saving python files
autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()

" Unable settings if filetype changes
let b:undo_ftplugin .= '|setlocal textwidth< colorcolumn<'
