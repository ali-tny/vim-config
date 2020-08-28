" Rename the current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')

    if filereadable(new_name)
        echo "File already exists"
        return
    endif

    if new_name != '' && new_name != old_name
        " Ensure that the folder exists
        let new_file_folder = fnamemodify(new_name, ":h")
        if isdirectory(new_file_folder) == 0
            exec ':!mkdir -p ' . new_file_folder
        endif

        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <leader>n :call RenameFile()<cr>
