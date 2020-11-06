function! UnitTestModuleFilepath(filepath)
    " Return the filepath of the corresponding unit test module to current
    " file.
    let path_segments = split(a:filepath, "/")
    let filename = path_segments[-1]

    " Ignore the underscore in "private" modules
    if filename =~ "^_"
        let filename = filename[1:]
    endif

    return "tests/unit/common/" . join(path_segments[1:-2], "/") . "/test_" . filename
endfunction

function! ApplicationModuleFilepath(filepath)
    " Return the filepath of the corresponding unit test module to current
    " file.
    let path_segments = split(a:filepath, "/")
    let index = index(path_segments, "tests")
    let filename = substitute(path_segments[-1], "test_", "", "")
    return "octoenergy/" . join(path_segments[index + 2:-2], "/") . "/" . filename
endfunction

function! ComplementaryFilepath(filepath)
    " Return the filepath of the corresponding unit-test or application module
    if match(a:filepath, "tests/") != -1
        return ApplicationModuleFilepath(a:filepath)
    else
        return UnitTestModuleFilepath(a:filepath)
    end
endfunction

function! PyTestOptions(filepath)
    " Return the options to run PyTest with
    
    " Unit tests
    
    if match(a:filepath, 'tests/unit/octoenergy') != -1 
        return " --ds=tests.settings --dc=OctoEnergyInterfaceAgnostic "
    endif
    
    if match(a:filepath, 'tests/unit/nectr') != -1
        return " --ds=tests.settings --dc=NectrInterfaceAgnostic "
    endif

    if match(a:filepath, 'tests/unit/goodenergy') != -1 
        return " --ds=tests.settings --dc=GoodEnergyInterfaceAgnostic "
    endif

    " Integration tests
    "
    if match(a:filepath, 'tests/integration/octoenergy') != -1
        return " --ds=tests.settings --dc=OctoEnergyInterfaceAgnostic "
    endif

    if match(a:filepath, 'tests/integration/nectr') != -1
        return " --ds=tests.settings --dc=NectrInterfaceAgnostic "
    endif
    
    if match(a:filepath, 'tests/integration/goodenergy') != -1
        return " --ds=tests.settings --dc=GoodEnergyInterfaceAgnostic "
    endif

    " Functional tests - consumer-sites

    if match(a:filepath, 'tests/functional/consumersite') != -1
        return " --ds=tests.settings --dc=OctoEnergyConsumerSite "
    endif

    if match(a:filepath, 'tests/functional/harpersite') != -1
        return " --ds=tests.settings --dc=HarperConsumerSite "
    endif

    if match(a:filepath, 'tests/functional/londonpowersite') != -1
        return " --ds=tests.settings --dc=LondonPowerConsumerSite "
    endif

    if match(a:filepath, 'tests/functional/commonsite') != -1
        return " --ds=tests.settings --dc=OctoEnergyConsumerSite "
    endif

    if match(a:filepath, 'tests/functional/affiliatesite') != -1
        return " --ds=tests.settings --dc=OctoEnergyAffiliateSite "
    endif

    " Functional tests - support-sites

    if match(a:filepath, 'tests/functional/supportsite/octoenergy') != -1
        return " --ds=tests.settings --dc=OctoEnergySupportSite "
    endif

    if match(a:filepath, 'tests/functional/supportsite/nectr') != -1
        return " --ds=tests.settings --dc=NectrSupportSite "
    endif

    if match(a:filepath, 'tests/functional/supportsite/goodenergy') != -1
        return " --ds=tests.settings --dc=GoodEnergySupportSite "
    endif

    " Functional tests - API-sites

    if match(a:filepath, 'tests/functional/apisite/octoenergy') != -1
        return " --ds=tests.settings --dc=OctoEnergyAPISite "
    endif

    if match(a:filepath, 'tests/functional/apisite/nectr') != -1
        return " --ds=tests.settings --dc=NectrAPISite "
    endif

    if match(a:filepath, 'tests/functional/apisite/goodenergy') != -1
        return " --ds=tests.settings --dc=GoodEnergyAPISite "
    endif

    " Functional tests - misc

    if match(a:filepath, 'tests/functional/webhooksite') != -1
        return " --ds=tests.settings --dc=OctoEnergyWebhookSite "
    endif

    if match(a:filepath, 'tests/functional/tasks') != -1
        return " --ds=tests.settings --dc=OctoEnergyWorker "
    endif

    if match(a:filepath, 'tests/functional/commands') != -1
        return " --ds=tests.settings --dc=OctoEnergyManagementCommand "
    endif

    return ""
endfunction

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
        let t:test_options = PyTestOptions(t:test_path)

        exec "silent :!clear"
        exec "silent :!echo -e \"Running \033[0;35m" . t:test_function . "\033[0m from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test -s " . t:test_options . t:test_module . " -k " . t:test_function
        exec "silent :!echo " . cmd
        exec ":!" . cmd
    end
endfunction

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
        let t:test_options = PyTestOptions(t:test_module)

        exec "silent :!clear"
        exec "silent :!echo -e \"Running tests from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test " . t:test_options . t:test_module 
        exec "silent :!echo " . cmd
        exec ":!" . cmd
    end
endfunction

" Mappings
" --------

" Run most recent test
nnoremap <buffer> <leader>t :call RunMostRecentTest()<cr>

" Run most recent test module
nnoremap <buffer> <leader>T :call RunMostRecentTestModule()<cr>

" Jump to the corresponding unit-test or application module
nnoremap <buffer> <leader>e :exec ":vsplit " . ComplementaryFilepath(expand("%"))<cr>
