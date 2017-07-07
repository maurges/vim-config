"disable banner
let g:netrw_banner = 0
"do not show dotfiles except for parent and .vim
". not followed by (. or vim)
let g:netrw_list_hide = '^\.\(\.\|vim\)\@!'
"use tree view as default
let g:netrw_liststyle = 3
"<C-^> will get you to last edited file, not netrw
let g:netrw_altfile = 1
