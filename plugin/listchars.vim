" Description: a small plugin to toggle the display of tabs. All configured
" for my taste of course
" Author: d86leader@github.com


nnoremap <silent> <Leader><Tab> :call listchars#toggle_listchars()<CR>
"toggle visibility at all
nnoremap <silent> <Leader><Leader>l :let &list = !&list<CR>
