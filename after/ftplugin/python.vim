setlocal textwidth=99

" Look in virtualenv for tags
set tags=./tags,tags,$VIRTUAL_ENV/tags

" Create Python-specific tags file. Note
" * `--python-kinds=cf` means only create entries for classes and functions (this requires using Universal Ctags)
" * `--tag-relative=yes` means store a path relative to location of tag file
nnoremap <buffer> <leader>ct :!ctags -f $VIRTUAL_ENV/tags --languages=python --python-kinds=cfi --tag-relative=yes --totals=yes<cr>

" Spellcheck comments
setlocal spell

" Make flake8 the default makeprg
setlocal makeprg=flake8

" Ale linting and fixing
let b:ale_linters = ['flake8']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
