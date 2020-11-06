" PEP8 stuff (don't really need this when black is running)
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Make flake8 the default makeprg
setlocal makeprg=flake8

" Ale linting and fixing
let b:ale_linters = ['flake8']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
