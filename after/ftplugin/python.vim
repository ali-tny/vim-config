setlocal textwidth=99

" Spellcheck comments
setlocal spell

" Use pydoc to look-up keywords
setlocal keywordprg=pydoc

" Make flake8 the default `makeprg`; `mypy` is another good option.
setlocal makeprg=flake8

" Ale linting and fixing
let b:ale_linters = ['flake8', 'mypy']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
