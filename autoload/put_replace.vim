" Description: see plugin/put_replace.vim for details

fun! s:keystroke_and_keep(keys, register) abort
	" if we used a named register, we shouldn't do anything. The unnamed
	" register will be changed, but i don't care about that in this context
	if v:register != '"'
		exec "normal! " . a:keys
		return
	endif

	let put_text = getreg(a:register)
	exec "normal! " . a:keys
	call setreg(a:register, put_text)
endfun

fun! put_replace#replace_normal(register) abort
	call s:keystroke_and_keep("Vp", a:register)
endfun

fun! put_replace#replace_visual(register) abort
	call s:keystroke_and_keep("p", a:register)
endfun
