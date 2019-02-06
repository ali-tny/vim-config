" Open help page when pressing K on keyword
setlocal keywordprg=:help

let b:undo_ftplugin .= '|setlocal keywordprg<'
