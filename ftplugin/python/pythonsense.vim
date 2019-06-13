" Customise python-sense
" ----------------------

" Disable bindings by default (we'll restore the ones we want shortly)
let g:is_pythonsense_suppress_object_keymaps = 1

" Customise the class text object mappings so we can use 'C' instead of the default 'c'
" to avoid a clash with the vim-textobj-comment plugin.
map <buffer> aC <Plug>(PythonsenseOuterClassTextObject)
map <buffer> iC <Plug>(PythonsenseInnerClassTextObject)

" Restore other useful objects using their default bindings
map <buffer> af <Plug>(PythonsenseOuterFunctionTextObject)
map <buffer> if <Plug>(PythonsenseInnerFunctionTextObject)
map <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
map <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
