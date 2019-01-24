function! DeleteTrailingWhiteSpace()
    " Use a mark to return cursor to original position
    exe "normal mz"
    " Delete all trailing whitespace
    %s/\s\+$//ge
    " Return cursor to mark
    exe "normal `z"
endfunction
