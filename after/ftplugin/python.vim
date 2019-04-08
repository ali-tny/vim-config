" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Delete trailing whitespace when saving
autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()

" Ale
" ---

let b:ale_linters = ['flake8']
let b:ale_fix_on_save = 1
let b:ale_fixers = ['black', 'isort']
