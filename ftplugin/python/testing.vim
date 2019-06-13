" Keyboard shortcuts for quickly running tests
" --------------------------------------------

function! RunMostRecentTestModule()
    " Run tests for the most *recent* test module.
    "
    " By "recent", I mean either:
    " 
    " - The test module that is currently being edited;
    " - The corresponding unit test module for the application module being
    "   edited.

    " Write all files before running any tests
    if expand("%") != ""
        :wall
    end

    " Check if we're editing a test module. If so, store the path in a
    " tab-scoped variable.
    if match(expand("%:t"), 'test_.*\.py$') != -1
        let t:test_module=@%
    else
        " If we're not editing a test module, look for the corresponding unit test
        " module for the production module we're in
        let test_module_filepath = UnitTestModuleFilepath(expand("%"))
        if filereadable(test_module_filepath)
            let t:test_module=test_module_filepath
        end
    end

    if !exists("t:test_module")
        echo "Don't know which test module to run!"
    else
        let t:test_options = ""

        let in_supportsite_test = match(t:test_module, 'tests/functional/support') != -1
        if in_supportsite_test
            let t:test_options = " --ds=tests.settings_support "
        endif

        let in_affiliatesite_test = match(t:test_module, 'tests/functional/affiliatesite') != -1
        if in_affiliatesite_test
            let t:test_options = " --ds=tests.settings_affiliates "
        endif

        let in_webhooksite_test = match(t:test_module, 'tests/functional/webhooksite') != -1
        if in_webhooksite_test
            let t:test_options = " --ds=tests.settings_webhooks "
        endif

        let in_apisite_test = match(t:test_module, 'tests/functional/apisite') != -1
        if in_apisite_test
            let t:test_options = " --ds=tests.settings_api "
        endif

        let in_harpersite_test = match(t:test_module, 'tests/functional/harpersite') != -1
        if in_harpersite_test
            let t:test_options = " --ds=tests.settings_harper "
        endif

        exec "silent :!clear"
        exec "silent :!echo -e \"Running tests from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test " . t:test_options . t:test_module 
        exec ":!" . cmd
    end
endfunction

function! UnitTestModuleFilepath(filepath)
    " Return the filepath of the corresponding unit test module to current
    " file.
    let path_segments = split(a:filepath, "/")
    let filename = path_segments[-1]
    return "tests/unit/" . join(path_segments[1:-2], "/") . "/test_" . filename
endfunction

nnoremap <buffer> <leader>T :call RunMostRecentTestModule()<cr>

" Jump to the corresponding unit test module
nnoremap <buffer> <leader>e :exec ":vsplit " . UnitTestModuleFilepath(expand("%"))<cr>

function! RunMostRecentTest()
    " Run the most recent test function

    " Write all files
    if expand("%") != ""
        :wall
    end

    " Check if we're editing a test module. If so, store the path in a var
    let in_test_file = match(expand("%"), 'test_.*\.py$') != -1
    if in_test_file
        " Grab the filepath module name
        let t:test_path = expand("%")
        let t:test_module = @%
        " Use a mark to return cursor to original position
        exe "normal mz"
        " Now walk back from cursor to last test function name. Note we need
        " to escape the <CR> to avoid vim thinking it's part of the search
        " query.
        normal $
        exec "normal! ?def test_?e\<cr>"
        let t:test_function = expand("<cword>")

        " If in test file, return cursor to original position
        exe "normal `z"
    end

    if !exists("t:test_module")
        echo "Don't know which test module to run!"
    elseif !exists("t:test_function")
        echo "Don't know which test function to run!"
    else
        " Check if in a package that requires specific pytest options
        let t:test_options = ""

        let in_supportsite_test = match(t:test_path, 'tests/functional/support') != -1
        if in_supportsite_test
            let t:test_options = " --ds=tests.settings_support "
        endif

        let in_affiliatesite_test = match(t:test_path, 'tests/functional/affiliatesite') != -1
        if in_affiliatesite_test
            let t:test_options = " --ds=tests.settings_affiliates "
        endif

        let in_webhooksite_test = match(t:test_module, 'tests/functional/webhooksite') != -1
        if in_webhooksite_test
            let t:test_options = " --ds=tests.settings_webhooks "
        endif

        let in_apisite_test = match(t:test_path, 'tests/functional/apisite') != -1
        if in_apisite_test
            let t:test_options = " --ds=tests.settings_api "
        endif

        let in_harpersite_test = match(t:test_path, 'tests/functional/harpersite') != -1
        if in_harpersite_test
            let t:test_options = " --ds=tests.settings_harper "
        endif

        exec "silent :!clear"
        exec "silent :!echo -e \"Running \033[0;35m" . t:test_function . "\033[0m from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test " . t:test_options . t:test_module . " -k " . t:test_function
        exec ":!" . cmd
    end
endfunction

nnoremap <buffer> <leader>t :call RunMostRecentTest()<cr>
