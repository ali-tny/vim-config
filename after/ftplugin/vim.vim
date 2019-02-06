" Allow wide lines
setlocal textwidth=0

" Use {{{ as a folder marker
setlocal foldmethod=marker

" Open help page when pressing K on keyword
setlocal keywordprg=:help

" Unable settings if filetype changes
let b:undo_ftplugin .= '|setlocal foldmethod< textwidth< keywordprg<'
