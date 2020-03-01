" See description in plugin/long_line.vim

fun! long_line#toggle_long_line() abort
	if exists("w:long_line_match_id")
		call matchdelete(w:long_line_match_id)
		unlet w:long_line_match_id
	else
		let w:long_line_match_id = matchadd("diffChange", '.\{81,\}')
	endif
endfun
