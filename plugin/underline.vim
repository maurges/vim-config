" Description: this plugin is used to quickly underline symbols and words with
" a hotkey

nnoremap gl a<C-R>="\u0332"<CR><ESC>l
vnoremap gl :<C-U>call Repeat_gl()<CR>

fun! Repeat_gl()
	let save_pos = getpos(".")
	normal '<
	let l = getpos("'<")
	let r = getpos("'>")
	let length = r[2] - l[2] + 1
	let i = 0
	while i < length
		normal gl
		let i += 1
	endwhile
	call setpos(".", save_pos)
endfun
