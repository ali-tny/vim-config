" PEP8 stuff (don't really need this when black is running)
setlocal textwidth=99
setlocal colorcolumn=100

" Spellcheck comments
setlocal spell

" Ale
" ---

let b:ale_linters = ['flake8']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']

" Folding
" -------
" Auto-unfold some files where folding isn't that useful.
" https://stevelosh.com/blog/2011/06/django-advice/#s25-editing-with-vim
" autocmd BufNewFile,BufRead file.py normal! zR
