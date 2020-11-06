setlocal textwidth=80
setlocal spell
setlocal nonumber
setlocal autoindent

" Hugo markdown files can have 'Vim: ' in their file metadata, which Vim
" treats as a modeline and spits out an error. We disabled modelines for
" markdown files.
setlocal nomodeline

" Unable settings if filetype changes.
let b:undo_ftplugin .= '|setlocal textwidth< spell< nonumber< autoindent< nomodeline<'

" Trim trailing whitespace when saving a file.
let b:ale_fixers = ['trim_whitespace']
