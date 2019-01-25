" Don't fold diffs
setlocal foldlevel=10

" Spellcheck commit messages
setlocal spell

" No line numbers
setlocal nonumber
setlocal norelativenumber

" Unable settings if filetype changes
let b:undo_ftplugin = '|setlocal foldlevel< spell< nonumber< norelativenumber<'
