function! textobj#camelword#select_i()
    " Look for start
    let match = search('[A-Z]', 'bc', line("."))
    if match == 0
        return 0
    endif
    let start_pos = getpos('.')
    normal! l

    " Look for end
    let end_match = search('[A-Z]', '', line("."))
    if end_match == 0
        echom "No end match"
        normal! e
        let end_pos = getpos('.')
    else
        " Found another capital - must be an inner camel-word.
        let end_pos = getpos('.')
        let end_pos[2] = end_pos[2] - 1
    endif

    return ['v', start_pos, end_pos]
endfunction


" Text fixtures:
"
" class TestSomethingIsBad()
