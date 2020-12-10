setlocal textwidth=99

" Create Python-specific tags file. Note
" * `--python-kinds=cf` means only create entries for classes and functions (this requires using Universal Ctags)
" * `--tag-relative=yes` means store a path relative to location of tag file
nnoremap <buffer> <leader>ct :!ctags -f $VIRTUAL_ENV/tags --languages=python --python-kinds=cfiv --tag-relative=yes --totals=yes<cr>

" Spellcheck comments
setlocal spell

" Use pydoc to look-up keywords
setlocal keywordprg=pydoc

" Make flake8 the default `makeprg`; `mypy` is another good option.
setlocal makeprg=flake8

" Ale linting and fixing
let b:ale_linters = ['flake8', 'mypy']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
