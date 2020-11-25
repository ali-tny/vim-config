" Config for Django HTML templates
" --------------------------------

" Mappings for wrapping tags with i18n tags
nnoremap <buffer> <leader>i vitc{% trans "" %}<ESC>4hp
vnoremap <buffer> <leader>i c{% trans "" %}<ESC>4hp

" Settings
" --------

" Don't break lines
setlocal textwidth=0

" Enable spell-checking
setlocal spell

" Unable settings if filetype changes
let b:undo_ftplugin .= '|setlocal textwidth< spell<'
