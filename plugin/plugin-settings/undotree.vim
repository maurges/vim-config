"undoTree settings
"don't open diff window
let g:undotree_DiffAutoOpen=0
"autofocus when opening window
let g:undotree_SetFocusWhenToggle=1

"better command to open
command! -nargs=0 Undotree :UndotreeToggle
