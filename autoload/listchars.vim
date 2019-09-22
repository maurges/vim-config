" See description in plugin/listchars.vim

let s:listchars_option = 0

fun! listchars#toggle_listchars() abort
	if !&list
		set list
		return
	endif
	if s:listchars_option == 1
		call listchars#unset()
		let s:listchars_option = 0
	else
		call listchars#set()
		let s:listchars_option = 1
	endif
endfun

fun! listchars#set() abort
	if has("windows")
		set listchars=tab:>-,trail:*,nbsp:*
	else
		set listchars=tab:▷-,trail:⋅,nbsp:⋅
	endif
endfun

fun! listchars#unset() abort
	if has("windows")
		set listchars=tab:\ \ ,trail:*,nbsp:*
	else
		set listchars=tab:\ \ ,trail:⋅,nbsp:⋅
	endif
endfun
