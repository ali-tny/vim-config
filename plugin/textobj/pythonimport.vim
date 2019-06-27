if exists('g:loaded_textobj_pythonimport')
  finish
endif

call textobj#user#plugin('pythonimport', {
\      '-': {
\        'select-i': 'im', '*select-i-function*': 'textobj#pythonimport#select_i',
\        'select-a': 'am', '*select-a-function*': 'textobj#pythonimport#select_a',
\      },
\    })

let g:loaded_textobj_pythonimport = 1
