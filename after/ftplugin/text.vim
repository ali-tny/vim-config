setlocal expandtab
setlocal autoindent

" Don't format into paras - allow to wrap instead.
setlocal wrap
setlocal linebreak

setlocal formatoptions=tron21

" Unable settings if filetype changes
let b:undo_ftplugin .= '|setlocal expandtab< autoindent< wrap< linebreak< formatoptions<'
