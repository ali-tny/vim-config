function! CharUnderCursor()
    " Return the character under the cursor
    return strcharpart(strpart(getline('.'), col('.') - 1), 0, 1)
endfun

function! textobj#pythonimport#select_i()
    " Check line is a Python import line
    let line = getline('.')
    let is_import_line = match(line, '^from ') != -1
    if is_import_line != 1
        return 0
    endif

    " Look for closing position
    let match = search(',\|$', '', line("."))
    if match == -1
        return 0
    endif
    let end_pos = getpos('.')

    " Move back one char if we're on a comma
    if CharUnderCursor() == ","
        let end_pos[2] -= 1
    endif

    " Look for starting position
    let match = search(',', 'b', line("."))
    if match == 0
        " Look for the preceding "import"
        let other_match= search('import', 'b', line("."))
        if other_match == 0
            return 0
        endif
        normal w
        let start_pos = getpos('.')
    else
        " Found a comma
        normal w
        let start_pos = getpos('.')
    endif

    return ['v', start_pos, end_pos]
endfunction

function! textobj#pythonimport#select_a()
    " Check line is a Python import line
    let line = getline('.')
    let is_import_line = match(line, '^from ') != -1
    if is_import_line != 1
        return 0
    endif

    " Look for closing position
    let match = search(',', '', line("."))
    let last_import = 0
    if match == 0
        " No comma found, jump to end of line
        normal $
        let last_import = 1
        let end_pos = getpos('.')
    else
        let end_pos = getpos('.')
        let end_pos[2] += 1
    endif

    " Look for starting position
    let match = search(',', 'b', line("."))
    if match == 0
        " Look for the preceding "import"
        let other_match= search('import', 'b', line("."))
        if other_match == 0
            return 0
        endif
        normal w
        let start_pos = getpos('.')
    else
        " Found a comma - move forward to start of next word.
        if last_import == 0
            normal w
        endif
        let start_pos = getpos('.')
    endif

    return ['v', start_pos, end_pos]
endfunction
