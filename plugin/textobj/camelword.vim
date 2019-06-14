if exists('g:loaded_textobj_camelword')
  finish
endif

" We don't define a select-a as it doesn't have meaning.
call textobj#user#plugin('camelword', {
\      '-': {
\        'select-i': 'ik', '*select-i-function*': 'textobj#camelword#select_i',
\      },
\    })

let g:loaded_textobj_camelword = 1
