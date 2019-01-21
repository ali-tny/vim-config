" ============= " VIMRC file for David Winterbottom (@codeinthehole) " ===========

" Inspiration {{{
" -----------
" Videos:
" - http://www.youtube.com/watch?v=aHm36-na4-4 
"
" Articles:
" - http://alexpounds.com/blog/2014/06/06/the-vimrc-antiques-roadshow
" - http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"
" Notable RC files:
" - https://bitbucket.org/sjl/dotfiles/src/562b7094aad5c602c6228c1d89f69d0abb3bab6b/vim/vimrc?at=default&fileviewer=file-view-default 
" - https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"
" Note, you can use K within this file to open the relevant help page
" }}}

" Vimscript notes {{{
" ---------------
" use | to split up two commands
" == depends on ignorecare setting (use ==#)
" functions must start with a capital (if they are unscoped)
"
" variables have various scopes:
"  g:var    - global
"  b:var    - local to buffer
"  l:var    - local to function
"  a:var    - a function arg
"  t:var    - local to tabpage
" See :internal-variables
" }}}

" .vim folder {{{
" ----------
"
" .vim/
"     bundle/              # Plugins
"     ftplugin/            # Per-filetype settings (these run when any buffer's filetype is set)
"                          # Should only use setlocal
"     indent/
"         htmldjango.vim   # Improved htmldjango indent script which handles
"                            block indentation (which the standard file doesn't).
"     syntax/              # Syntax highlighting that isn't in core
"         puppet.vim       # (Can this be replaced with a plugin?)
"
" }}}

" Vundle and plugins {{{
" ------------------

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" All plugins need to be declared here
" Run :PluginInstall to install them
" Run :PluginUpdate to update

" Package manager
Plugin 'VundleVim/Vundle.vim'

" Editing 
" -------

" Mappings for editing surrounding delimiters, tags etc, eg
"   cs"<em>     => Change Surrounding quotes to <em> tags
"   ysiw[       => applY Surrounding brackets to word (iw)
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Non-standard text-objects
" -------------------------

" Provides lots of textobjects
" Eg 'separator text objects' - delimited by one of , . ; : + - = ~ _ * # /
Plugin 'wellle/targets.vim'

" Define 'a' as a text obj for a function argument. So you can use 'cia' to
" change a function arg. 
Plugin 'vim-scripts/argtextobj.vim'

" Use 'i' as a text obj for an indented block
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'  " requirement of vim-textobj-indent

" use 'l' for the whole line (useful with vim-surround)
Plugin 'kana/vim-textobj-line'

" Use 'f' for function, 'c' for class
Plugin 'bps/vim-textobj-python'

" Custom text objects for Django templates
"   Use 'db' for block
"   Use 'df' for for loop
"   Use 'dv' for {{ var }}
"   Use 'dt' for {% tag %}
" Plus others starting with d
Plugin 'mjbrownie/django-template-textobjects'

" Navigation
" ----------

" Quick file/buffer/tag searching (faster than CtrlP)
" ctrl-v - open file in split
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Shows 'Match X of Y' in command bar
Plugin 'henrik/vim-indexed-search'

" Syntax highlighting and indentation
" -----------------------------------

" Language pack with syntax and indent files for a range of language
Plugin 'sheerun/vim-polyglot'

" Python indentation (still required as of vim 8 - disabled on 2018-01-15 to
" check if vimpolyglot covers it)
"Plugin 'vim-scripts/indentpython.vim'

" Better markdown support. This plugin provides:
" - highlighting of fenced code blocks
" - highlighting of frontmatter
" - folding
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Folding
" -------

" Extend % matching to include HTML tags
Plugin 'tmhedberg/matchit'

" Git(hub) integration
" :Gstatus
" :Gbrowse! - copy Github URL to clipboard
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

" More sophisticated last-position opening which ignores gitcommit
Plugin 'dietsche/vim-lastplace'

" Linting 
" -------

" Not sure if ale is slowing things down
Plugin 'w0rp/ale'
"Plugin 'vim-syntastic/syntastic'

" Run 'black' on save - quite useful but needs the project to have a
" wholesales conversion first.
"Plugin 'ambv/black'

" HTML editing
" ------------

" Another quick way of writing tags - use C-E to expand the shorthand syntax
" eg .container > .wrapper > ul > li.item * 4
Plugin 'rstacruz/sparkup'

" Color scheme
" ------------

" See http://vimcolors.com/
"Plugin 'flazz/vim-colorschemes'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

call vundle#end()

" }}}

" Core {{{
" ----
" Use Vim settings, rather then Vi settings (much better! we don't need to be
" backwards compatible).  This must be first, because it changes other options
" as a side effect.
set nocompatible

" Switch syntax highlighting on when the terminal has colors
if &t_Co > 2 || has("syntax")
    syntax on
endif

filetype indent plugin on               " Turn on filetype detection

" }}}
 
" Leader keys {{{
" ----------- 
" Comma is easy to type
let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","
" }}}

" Editing behaviour {{{
set backspace=indent,eol,start          " Allow backspacing over everything in insert mode
set scrolloff=3                         " Controls when to scroll winow
set showmatch                           " Show matching delimiters
set showmode                            " Show mode changes
set matchtime=1                         " Jump to matching bracket for 1/10ths of a second
set autoindent                          " Always set autoindenting on
set copyindent                          " Copy previous indentation
set nowrap                              " Don't word wrap
set shiftround                          " Round indent to multiple of 'shiftwidth'
set smarttab                            " Allow backspacing of a shiftwidth of spaces
set noeol                               " Prevent a carriage return at end of last line
set lazyredraw                          " Don't redraw while executing macros (for performance)
set nojoinspaces                        " Don't insert two spaces after sentence joins
set diffopt+=iwhite

set tabstop=4                           " Length of tab in spaces
set softtabstop=4                       " Number of spaces to add when you hit <tab>
set expandtab                           " Expand tabs into spaces
set shiftwidth=4
set formatoptions=tcqo2j                " Control how gq behaves see `fo-table`
                                        " t = wrap to textwidth
                                        " c = insert leading comment char automatically
                                        " q = apply when using gq
                                        " o = insert leading comment char when hitting o
                                        " 2 = control indenting of para (needed for Python docstring) 
                                        " j = remove comment markers where it makes sense
                                        
" Control how long vim waits for another key                                        
set timeoutlen=500                                        

" Treat hyphens as part of a word
set iskeyword+=-

" Treat numbers as decimal (eg when incrementing with C-a)
set nrformats=

" }}}

" Command line behaviour {{{
set completeopt=longest,menuone,preview " Insert mode completion options
set complete-=i
set history=10000                       " Number of lines in command line history
set showcmd                             " Display incomplete commands
set wildmenu                            " Use menu to show command line completions
set wildmode=list:longest,full          " Command-line completion
set wildignore+=*.pyc,*egg-info*        " Define files to ignore

set shellslash                          " A forward slash is used when expanding filenames
" Reverting to see if get more realestate
set cmdheight=1
"set cmdheight=3                         " Try and avoid the dreaded "press <Enter> to continue" by setting the 
"                                        " the height of the command bar
" }}}

" Appearance {{{
set ruler                               " Show the cursor position all the time in the status bar
set pastetoggle=<F11>                   " Toggle paste mode using F11
set confirm                             " Prompt for unsaved files
set title                               " Set window title to filename
set nonumber                            " Set line numbers
let &titleold=""

set winminheight=0                      " Allows windows to be fully squashed
set equalalways                         " Keep windows equally sized
" }}}

" Folding {{{
set foldenable
set foldmethod=syntax
set foldlevel=0
set foldnestmax=2
set foldlevelstart=0                    " Starting fold level for a new buffer
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}

" Terminal {{{
if ! has("gui_running")
    set term=xterm-256color
    set termencoding=utf-8
    set ttyfast                         " Faster output (vim updates screen in bigger batches)
endif

set encoding=utf-8                      " Use UTF-8 as the default buffer encoding

" }}}

" Mouse {{{
set mouse=a                             " Enables use of mouse in all modes
set mousehide                           " Hide mouse when typing
" }}}

" Display {{{
set shortmess=atI                       " Prevent file messages appearing
set visualbell                          " Rather than beeps
set noerrorbells                        
set virtualedit=block
" }}}

" Files/buffers {{{
set hidden                              " Don't abandon unloaded buffers, hide them instead
set fileformats=unix                    " File format
set autowrite                           " Auto-write file if modified on exit
set autoread                            " Auto-load file if it changes elsewhere
set nobackup                            " Don't keep a back-up file, they're annoying
set noswapfile
" }}}

" Searching and highlighting {{{
set wrapscan                            " Wrap searching
set incsearch                           " Do incremental searching
set gdefault                            " Global setting on by default in subsituting
set ignorecase                          " Ignore case when searching..
set smartcase                           " ..but use case when search term has an uppder-case char
set magic
set hlsearch                            " Highlight all search results (sometimes annoying)
set synmaxcol=200                       " Don't try to highlight long lines (for performance)
set cursorline                          " Highlight the line being edited

" Highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Use rg for the :grep program (as it's faster than ag)
"   * use "-t html" to only search one filetype
"   * use "-w" to match on word boundaries
if executable('rg') 
    "set grepprg=rg\ --no-heading\ --color=never\ --column
    " Try vimgrep option
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif 

" }}}

" History  {{{
" Keep undo history between sessions
if has('persistent_undo')
    set undofile
    set undodir=~/.vim_undo
    set undolevels=2000
endif
" }}}

" GUI options {{{
" Note - when running in console mode, the font is taken from iTerm
if has("gui_running")
    " Set GUI options
    set guioptions-=m           " Lose toolbar, menu and scrollbar
    set guioptions-=T     
    set guioptions-=r    
    set guioptions-=L
    " Colors/font
    set guifont=Monaco:h14
    set selectmode=""
endif
" }}}

" Command-mode mappings {{{
" ---------------------

" Use %% to expand to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" }}}

" Operator-pending mappings {{{ 
" -------------------------
" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html
" http://vimdoc.sourceforge.net/htmldoc/map.html#omap-info
"
" Closely related to text objects

" Text object for next set of (parentheses)
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>

" }}}

" Abbreviations {{{

" Auto-correct common typos
iabbrev si is
iabbrev tehn then

" }}}

" Plugin config and mappings {{{
" ==========================
" I'd like this section to be next to the Vundle declarations but that causes
" some things to break.
"
" FZF
" ---

" Map leader keys to common actions
nnoremap <leader>f :Files<cr> 
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>s :Tags<cr>

" Open FZF window at bottom of screen
let g:fzf_layout = { 'down': '~40%' }

" Markdown
" --------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['php', 'python', 'js=javascript', 'bash=sh', 'viml=vim']
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" Vim-go
" ------
let g:go_fmt_command = "goimports"          " ensure imports are correct save

" This prevents confusion on :GoTest failures where vim-go can't work out
" where to jump to (because of the altered output from testify). See
" https://github.com/fatih/vim-go/issues/367
let g:go_jump_to_error = 0

" Sparkup
" -------
let g:sparkupNextMapping = "<NOP>"

" Syntastic 
" --------- 
" Defaults (from README)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

" Python folding
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_import = 0

" Polyglot
let g:terraform_fmt_on_save = 1

" Black (disabled)
" let g:black_linelength = 99
" let g:black_skip_string_normalization = 1

" Ale
" ---
" Only run flake8 for Python linting as running MyPy is slow.
let g:ale_linters = {'python': ['flake8']}

" Jump between syntax errors
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)

" }}}
 
" Mappings {{{
" ===========
 
" GLOBAL
" ------

" Make useless key useful again (UK Mac keyboard issue...)
set pastetoggle=§

" Copy to system clipboard
map <leader>y "*y

" INSERT MODE
" -----------

" Alias for escape - see http://cloudhead.io/2010/04/24/staying-the-hell-out-of-insert-mode/
inoremap kj <ESC>
inoremap <ESC> <NOP>

" No more cursor keys! 
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

" Mimic some emacs shortcuts that work in bash

" Delete line (replaces insert one shiftwidth of indent)
inoremap <C-d> <ESC>ddi     

" Jump to end of line (replaces insert the character below the cursor)
inoremap <C-e> <ESC>A

" Jump to start of line (replaces insert previously inserted text)
inoremap <C-a> <ESC>I

" Make word under cursor uppercase (delete to start of line)
inoremap <C-u> <ESC>viwUi

" Indent current line
inoremap <C-=> <ESC>V=i

" Format current paragraph
inoremap <C-f> <ESC>vipgqi

" Save and quit from insert mode
inoremap <leader><leader> <ESC>:wq<CR>

" Shortcut to insert pdb
inoremap <C-J> import ipdb; ipdb.set_trace() 


" NORMAL MODE
" -----------

" Alias for : to avoid hitting shift all the time
nnoremap ; :

" Disable cursors
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

" Search codebase for word under cursor (v useful)
nnoremap gw :grep <cword> . <CR>

" Search codebase for current filename
nnoremap gW exe 'normal :grep' . expand('%:t') . '.'

" Jump to definition of word under cursor
nnoremap gd <c-]>
nnoremap gD <c-w>v<c-w>l<c-]> 

" Jump to alternate file
nnoremap <leader><leader> <c-^>

" Make yank consistent with other commands
nnoremap Y y$

" Cursor moves up/down on the screen, not lines in the file
nnoremap j gj
nnoremap k gk

" Format paragraph
nnoremap Q gqap

" Stop cursor jumping when joining lines
nnoremap J mzJ`z

" Put result in centre of window when jumping between search results
nnoremap n nzz
nnoremap N Nzz

" Space is pager
nnoremap <Space> <PageDown>

" Jump between search matches (from the error list) when using :grep and open
" the folds obscuring the matching line.
nnoremap <silent> <RIGHT> :cnext<CR>zO
nnoremap <silent> <LEFT> :cprev<CR>

" Open folds after jumping
nnoremap n nzO
nnoremap N NzO

" Typos
nnoremap :W :w
nnoremap :E :e
nnoremap :Q :q

" Use backspace to turn off highlighted search terms
nnoremap <BS> :nohlsearch<CR>

" Select the last thing pasted (compliments gv which selects the last visual
" selection).
nnoremap gV `[v`]

" VISUAL MODE
" -----------

" Leave cursor at the end of the yanked block
vnoremap y y']

" Move visual block
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv

" Leading mappings
" ----------------

" Faster saving and quiting
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wqa<CR>

" Open vimrc in new window
nnoremap <leader>ve :e ~/.vimrc<CR>

" Create tags file. This could be made fancier as the default config file
" (~/.ctags) is quite python specific at the moment.
nnoremap <leader>ct :!ctags<cr>

" VISUAL MODE
" -----------

" When in visual mode, retain visual selection after action
function! ShiftAndKeepVisualSelection(cmd) 
    set nosmartindent
    if mode() =~ '[Vv]'
        return a:cmd . ":setlocal smartindent\<CR>gv" 
    else
        return a:cmd . ":setlocal smartindent\<CR>"
    endif 
endfunction

vnoremap <expr> > ShiftAndKeepVisualSelection(">") 
vnoremap <expr> < ShiftAndKeepVisualSelection("<")

" }}}

" Status bar {{{
set showmode                            " Display which mode we're in
set laststatus=2                        " Always show status bar
if has('statusline') 
    " Notes:
    " %n = buffer number
    " %f = path to file
    " %y = filetype
    " %l = line number
    " %L = total lines in file
    " 
    set statusline=%n\:\ %f\ %y\ 
    set statusline+=%=
    set statusline+=%#warningmsg#
    set statusline+=%*
    set statusline+=col\ %c\ line\ %l/%L
endif
" }}}

" Tags {{{
" ----

" Where to find tags file
set tags=./tags,tags,$VIRTUAL_ENV/tags

" }}}

" Autocommands {{{
" ------------
" All autocmds should be in a group so they can be re-sourced
" without side-effect.
" http://learnvimscriptthehardway.stevelosh.com/chapters/12.html
"
" Notes:
"
" - Each group starts with autocmd! to remove all existing commands for that
"   group. This prevents each sourcing from adding duplicate autocommands
"

augroup filetype_python 
    autocmd!
    " Delete trailing whitespace when saving python files
    " autocmd BufWrite *.py :call DeleteTrailingWhiteSpace()
    " Enable python.django filetype for all python files
    autocmd FileType python set filetype=python.django 
    " Run Black auto-formatter on pre-save
    " autocmd BufWritePre *.py execute ':silent :Black'

augroup END

function! DeleteTrailingWhiteSpace()
    " Use a mark to return cursor to original position
    exe "normal mz"
    " Delete all trailing whitespace
    %s/\s\+$//ge
    " Return cursor to mark
    exe "normal `z"
endfunction

augroup filetype_javascript
    autocmd!
    " Remove tabs from JS files
    autocmd BufNewFile *.js :retab<CR>
augroup END

augroup filetime_html
    autocmd!
    " Use htmldjango as file-type for HTML files
    autocmd FileType html set filetype=htmldjango
augroup END

" Set filetypes based on file extensions
augroup set_filetypes
    autocmd!

    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.scala set filetype=scala
    autocmd BufRead,BufNewFile *.pp set filetype=puppet
    autocmd BufRead,BufNewFile *.sls set filetype=yaml
    autocmd BufRead,BufNewFile *.rml set filetype=xml

    autocmd BufRead,BufNewFile PULLREQ_EDITMSG set filetype=gitcommit

augroup END

augroup cursorline
    autocmd!
    " Only show the cursorline for current buffer in normal mode  
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
augroup END
 
" Auto-source vimrc after save
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup windows
    autocmd!
    " Resize splits when a window is created, closed or resized
    autocmd WinEnter,VimResized * :wincmd =

augroup END

" }}}

" Colorscheme  {{{
" -----------
" These needs to be near the end of ~/.vimrc for some reason
if &t_Co >= 256 || has("gui_running")
    " Don't complain if colorscheme doesn't exist (zenburn)
    silent! colorscheme zenburn
    set background=dark  
else
    set background=light
    colorscheme solarized
endif

" Tweaks for markdown rendering
" List of colors: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
highlight htmlH1 guifg=#42dff4 gui=bold ctermfg=51 ctermbg=None cterm=bold
highlight htmlH2 guifg=#af84e0 gui=bold ctermfg=45 ctermbg=None cterm=bold
highlight htmlH3 guifg=#aae295 gui=bold ctermfg=39 ctermbg=None cterm=bold
highlight htmlH4 guifg=#e9f2b3 gui=bold ctermfg=33 ctermbg=None cterm=bold

" Taken from https://www.reddit.com/r/vim/comments/3duumy/changing_markdown_syntax_colors/
" Run :call GetSyntax() to show highlight settings for word under cursor
function! GetSyntaxID()
    return synID(line('.'), col('.'), 1)
endfunction

function! GetSyntaxParentID()
    return synIDtrans(GetSyntaxID())
endfunction

function! GetSyntax()
    echo synIDattr(GetSyntaxID(), 'name')
    exec "hi ".synIDattr(GetSyntaxParentID(), 'name')
endfunction

" }}}
