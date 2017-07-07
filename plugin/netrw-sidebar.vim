" Description: A small simple plugin for nerdtree-like netrw sidebar
" see second part in after/ftplugin/netrw.vim
" as it can't be split from my configuration

"controls width of the split
let g:netrw_sidebar_width = 30


fun! s:netrw_sidebar_open_at(place)
	if exists('t:netrw_sidebar_id')
		"go to it if exists
		exec t:netrw_sidebar_id . "wincmd w"
		return
	endif
	"open, go to it, resize and set variables
	exec "Lexplore " . a:place
	exec "vertical resize" . g:netrw_sidebar_width
	let t:netrw_sidebar_id = winnr()
	let b:is_netrw_sidebar = 1
endfun

fun! s:netrw_sidebar_close()
	if !exists('t:netrw_sidebar_id')
		return
	endif
	exec  t:netrw_sidebar_id . "wincmd q"
	unlet t:netrw_sidebar_id 
endfun

fun! s:netrw_sidebar_toggle()
	if exists('t:netrw_sidebar_id')
		call s:netrw_sidebar_close()
	else
		call s:netrw_sidebar_open_at('./')
	endif
endfun


command!                         NetrwSidebar   :call <SID>netrw_sidebar_open_at('./')
command! -nargs=1 -complete=file NetrwSidebarAt :call <SID>netrw_sidebar_open_at(<args>)

command! NetrwSidebarClose  :call <SID>netrw_sidebar_close()
command! NetrwSidebarToggle :call <SID>netrw_sidebar_toggle()
