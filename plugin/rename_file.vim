" Rename the current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if filereadable(new_name)
        echo "File already exists"
        return
    endif
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <leader>n :call RenameFile()<cr>
