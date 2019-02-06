setlocal textwidth=80
setlocal spell
setlocal nonumber

" Unable settings if filetype changes
let b:undo_ftplugin .= '|setlocal textwidth< spell< nonumber<'
