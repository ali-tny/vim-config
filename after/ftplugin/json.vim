" This file gets sourced for markdown files where we do want spelling turned on.
if &filetype ==# "json"
    " Spelling has way too many false positives
    setlocal nospell
endif
