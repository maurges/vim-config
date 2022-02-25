" Description: quickly diff split windows. Automatically stop diffing when one
" window is closed

fun! s:start_diff() abort
	setlocal diff cursorbind scrollbind nowrap
	autocmd BufWinLeave <buffer> windo call <SID>stop_diff()
endfun

fun! s:stop_diff() abort
	setlocal nodiff nocursorbind noscrollbind wrap
endfun

"quickly diff files in split windows
silent! command! -nargs=0 Diff   :windo call <SID>start_diff()
silent! command! -nargs=0 Nodiff :windo call <SID>stop_diff()
