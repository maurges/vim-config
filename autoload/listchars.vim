" See description in plugin/listchars.vim

let s:listchars_option = 0

fun! listchars#toggle_listchars() abort
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
