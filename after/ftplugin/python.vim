" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Delete trailing whitespace when saving
autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()

" Ale
" ---

" Only run flake8 for Python linting as running MyPy is slow.
let b:ale_linters = ['flake8']

" Run black and isort when fixing
let b:ale_fixers = ['black', 'isort']

" Run fixers when saving (in appropriate repos)
let b:ale_fix_on_save = 0

let filepath = expand('%:p:h')
if match(filepath, 'email-classification') != -1
    let b:ale_fix_on_save = 1
elseif match(filepath, 'credit-risk-engine') != -1
    let b:ale_fix_on_save = 1
endif
