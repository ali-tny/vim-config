" AWS config files
autocmd BufRead,BufNewFile */.aws/* setfiletype dosini
autocmd BufRead,BufNewFile */aws/* setfiletype dosini

" Env files
autocmd BufRead,BufNewFile *.env setfiletype dosini

" Ctags config files
autocmd BufRead,BufNewFile *.ctags setfiletype dosini


