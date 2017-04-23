"it's no use having relative numbers in quickfix
setlocal norelativenumber
"someone recommended having qf removed from buffer list
setlocal nobuflisted
"i like it more without cursorline
setlocal nocursorline

"some maps to select errors

"open error
nnoremap <buffer> <silent> o <CR>
"open error in horizontal split
nnoremap <buffer> <silent> s <C-W><CR>
"open error in vertical split
nnoremap <buffer> <silent> v <C-W><CR><C-W>L<C-W>p<C-W>J
"open error in new tab
nnoremap <buffer> <silent> t <C-W><CR><C-W>T
