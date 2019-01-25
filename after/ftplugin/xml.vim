" ============
" XML SETTINGS
" ============

setlocal shiftwidth=4
setlocal expandtab

" Format XML - using my own python script for formatting XML
" See https://gist.github.com/3181820
nnoremap <buffer> <leader>F ggVG !xmlformat<CR>
