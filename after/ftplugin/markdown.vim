setlocal textwidth=80
setlocal spell
setlocal nonumber
setlocal autoindent

" Use custom wrapper around MacOS dictionary as keyword look-up
setlocal keywordprg=open-dict

" Hugo markdown files can have 'Vim: ' in their file metadata, which Vim
" treats as a modeline and spits out an error. We disabled modelines for
" markdown files.
setlocal nomodeline

" Trim trailing whitespace when saving a file.
let b:ale_fixers = ['trim_whitespace']

" Unable settings if filetype changes.
let b:undo_ftplugin .= '|setlocal textwidth< spell< nonumber< autoindent< nomodeline<'

