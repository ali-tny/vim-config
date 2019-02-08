setlocal filetype=python.django 

" PEP8 stuff
setlocal textwidth=99
setlocal colorcolumn=100

" Delete trailing whitespace when saving python files
autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()

" Only run flake8 for Python linting as running MyPy is slow.
let b:ale_linters = ['flake8']
