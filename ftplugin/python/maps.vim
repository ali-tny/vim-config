" Fast folding by indent
setlocal foldmethod=indent

function! VirtualEnvSitePackagesFolder()
    " Try a few candidate Pythons to see which this virtualenv uses.
    for python in ["python3.7", "python3.8", "python3.9"]
        let candidate = $VIRTUAL_ENV . "/lib/" . python
        if isdirectory(candidate)
            return candidate . "/site-packages/"
        endif
    endfor

    return ""
endfunction

cnoremap <buffer> %v <C-R>=VirtualEnvSitePackagesFolder()<cr>

" Shortcut to insert debugger breakpoint.
inoremap <buffer> <C-J> breakpoint()

