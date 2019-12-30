" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Ale
" ---

let b:ale_linters = ['flake8']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
