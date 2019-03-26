" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Delete trailing whitespace when saving
autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()

" Ale
" ---

" Don't run flake8 if we're auto-running black/isort
let b:ale_fix_on_save = 1
let b:ale_linters = []
let b:ale_fixers = ['black', 'isort']

" But do use flake8 if not
let filepath = expand('%:p:h')
if match(filepath, 'consumer-site') != -1
    let b:ale_fix_on_save = 0
    let b:ale_linters = ['flake8']
endif
