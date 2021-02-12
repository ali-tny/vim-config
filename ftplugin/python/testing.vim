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

function! PyTestConfiguration(filepath)
    " Return the configuration to run the test at filepath.
    let configurations = {
            \"tests/unit/common": "InterfaceAgnostic",
            \"tests/unit/gbr": "GbrInterfaceAgnostic",
            \"tests/unit/aus": "AusInterfaceAgnostic",
            \"tests/unit/octoenergy": "OctoEnergyInterfaceAgnostic",
            \"tests/unit/nectr": "NectrInterfaceAgnostic",
            \"tests/unit/goodenergy": "GoodEnergyInterfaceAgnostic",
            \"tests/unit/eonnext": "EonNextInterfaceAgnostic",
            \"tests/unit/origin": "OriginInterfaceAgnostic",
            \"tests/unit/oeg": "OEGInterfaceAgnostic",
            \"tests/unit/oeus": "OEUSInterfaceAgnostic",
            \"tests/integration/common": "InterfaceAgnostic",
            \"tests/integration/gbr": "GbrInterfaceAgnostic",
            \"tests/integration/aus": "AusInterfaceAgnostic",
            \"tests/integration/octoenergy": "OctoEnergyInterfaceAgnostic",
            \"tests/integration/nectr": "NectrInterfaceAgnostic",
            \"tests/integration/goodenergy": "GoodEnergyInterfaceAgnostic",
            \"tests/integration/eonnext": "EonNextInterfaceAgnostic",
            \"tests/integration/origin": "OriginInterfaceAgnostic",
            \"tests/integration/oeg": "OEGInterfaceAgnostic",
            \"tests/integration/oeus": "OEUSInterfaceAgnostic",
            \"tests/functional/consumersite": "OctoEnergyConsumerSite",
            \"tests/functional/harpersite": "HarperConsumerSite",
            \"tests/functional/londonpowersite": "LondonPowerConsumerSite",
            \"tests/functional/commonsite": "OctoEnergyConsumerSite",
            \"tests/functional/affiliatesite": "OctoEnergyAffiliateSite",
            \"tests/functional/supportsite/common": "OctoEnergySupportSite",
            \"tests/functional/supportsite/gbr": "OctoEnergySupportSite",
            \"tests/functional/supportsite/aus": "NectrSupportSite",
            \"tests/functional/supportsite/octoenergy": "OctoEnergySupportSite",
            \"tests/functional/supportsite/nectr": "NectrSupportSite",
            \"tests/functional/supportsite/goodenergy": "GoodEnergySupportSite",
            \"tests/functional/supportsite/eonnext": "EonNextSupportSite",
            \"tests/functional/supportsite/origin": "OriginSupportSite",
            \"tests/functional/supportsite/oeg": "OEGSupportSite",
            \"tests/functional/supportsite/oeus": "OEUSSupportSite",
            \"tests/functional/apisite/common": "OctoEnergyAPISite",
            \"tests/functional/apisite/uk": "OctoEnergyAPISite",
            \"tests/functional/apisite/aus": "NectrAPISite",
            \"tests/functional/apisite/octoenergy": "OctoEnergyAPISite",
            \"tests/functional/apisite/nectr": "NectrAPISite",
            \"tests/functional/apisite/goodenergy": "GoodEnergyAPISite",
            \"tests/functional/apisite/eonnext": "EonNextAPISite",
            \"tests/functional/apisite/origin": "OriginAPISite",
            \"tests/functional/apisite/oeg": "OEGAPISite",
            \"tests/functional/apisite/oeus": "OEUSAPISite",
            \"tests/functional/webhooksite/common": "OctoEnergyWebhookSite",
            \"tests/functional/webhooksite/octoenergy": "OctoEnergyWebhookSite",
            \"tests/functional/webhooksite/nectr": "NectrWebhookSite",
            \"tests/functional/webhooksite/goodenergy": "GoodEnergyWebhookSite",
            \"tests/functional/webhooksite/eonnext": "EonNextWebhookSite",
            \"tests/functional/webhooksite/origin": "OriginWebhookSite",
            \"tests/functional/webhooksite/oeg": "OEGWebhookSite",
            \"tests/functional/webhooksite/oeus": "OEUSWebhookSite",
            \"tests/functional/tasks/common": "OctoEnergyWorker",
            \"tests/functional/tasks/gbr": "OctoEnergyWorker",
            \"tests/functional/tasks/aus": "NectrWorker",
            \"tests/functional/tasks/octoenergy": "OctoEnergyWorker",
            \"tests/functional/tasks/nectr": "NectrWorker",
            \"tests/functional/tasks/goodenergy": "GoodEnergyWorker",
            \"tests/functional/tasks/eonnext": "EonNextWorker",
            \"tests/functional/tasks/origin": "OriginWorker",
            \"tests/functional/tasks/oeg": "OEGWorker",
            \"tests/functional/tasks/oeus": "OEUSWorker",
            \"tests/functional/commands/common": "OctoEnergyManagementCommand",
            \"tests/functional/commands/gbr": "OctoEnergyManagementCommand",
            \"tests/functional/commands/aus": "NectrManagementCommand",
            \"tests/functional/commands/octoenergy": "OctoEnergyManagementCommand",
            \"tests/functional/commands/nectr": "NectrManagementCommand",
            \"tests/functional/commands/goodenergy": "GoodEnergyManagementCommand",
            \"tests/functional/commands/eonnext": "EonNextManagementCommand",
            \"tests/functional/commands/origin": "OriginManagementCommand",
            \"tests/functional/commands/oeg": "OEGManagementCommand",
            \"tests/functional/commands/oeus": "OEUSManagementCommand",
            \"tests/functional/events/gbr": "OctoEnergyWorker",
            \"tests/functional/events/deu": "OEGWorker",
            \"tests/functional/events/aus": "OriginWorker",
            \"tests/multidb": "MultiDB",
    \}
    echom a:filepath
    for path in keys(configurations) 
        if match(a:filepath, path) != -1
            return configurations[path]
        endif
    endfor

    return "InterfaceAgnostic"
endfunction

function! PyTestOptions(filepath)
    " Return the options to run PyTest with
    
    let configuration = PyTestConfiguration(a:filepath)

    return " --ds=tests.settings --dc=" . configuration . " "
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
