" Description: a small plugin to toggle the display of tabs. All configured
" for my taste of course
" Author: d86leader@github.com


let s:listchars_option = 0

fun! s:toggle_listchars() abort
	if !&list
		set list
		return
	endif
	if s:listchars_option == 1
		set listchars=tab:\ \ ,trail:⋅,nbsp:⋅
		let s:listchars_option = 0
	else
		set listchars=tab:▷-,trail:⋅,nbsp:⋅
		let s:listchars_option = 1
	endif
endfun

nnoremap <silent> <Leader><Tab> :call <SID>toggle_listchars()<CR>
"toggle visibility at all
nnoremap <silent> <Leader><Leader>l :let &list = !&list<CR>
