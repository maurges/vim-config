" Description: functions for my netrw-sidebar plugin i rarely now use
" see plugin/netrw-sidebar.vim and after/ftplugin/netrw.vim

fun! netrw_sidebar#open_at(place)
	if exists('t:netrw_sidebar_id')
		"go to it if exists
		exec t:netrw_sidebar_id . "wincmd w"
		return
	endif
	"open, go to it, resize and set variables
	exec "Lexplore " . a:place
	exec "vertical resize" . g:netrw_sidebar_width
	"unset the variable controlling where the opening takes place
	let g:netrw_chgwin = -1
	"set technical info
	let t:netrw_sidebar_id = winnr()
	let w:is_netrw_sidebar = 1
endfun

fun! netrw_sidebar#close()
	if !exists('t:netrw_sidebar_id')
		return
	endif
	exec  t:netrw_sidebar_id . "wincmd q"
	unlet t:netrw_sidebar_id 
endfun

fun! netrw_sidebar#toggle()
	if exists('t:netrw_sidebar_id')
		call netrw_sidebar#close()
	else
		call netrw_sidebar#open_at('./')
	endif
endfun



