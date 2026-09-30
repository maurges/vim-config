" Description: quickly diff split windows. Automatically stop diffing when one
" window is closed

"quickly diff files in split windows
silent! command! -nargs=0 Diff   :windo diffthis
silent! command! -nargs=0 Nodiff :diffoff!
