" Description: small plugin to replace word under cursor in all files you edit


"hotkey to quickly replace word under cursor
nnoremap <F2> yiw:call <sid>replace_all('<C-R>"')<CR>
"and quickly replace all occurences of selected text
xnoremap <F2> y:call <sid>replace_all('<C-R>"')<CR>

fun! s:replace_all(word) abort
	" remember starting position
	let ini_pos = getpos(".")
	let ini_buf = bufnr("%")

	let prompt = "Replace: " . a:word . " --> "
	let repl = input(prompt)

	" bufdo stops when it encounters a directory browser
	" but doesn't in the try block, even though error is never caught
	try
		bufdo call <sid>replace_in_buffer(a:word, repl)
	catch /.*/
		echoerr "Error caught: " v:exception
	endtry

	" return to starting position
	exec "buffer " . ini_buf
	call setpos(".", ini_pos)
endfun

" replace in one buffer if should
fun! s:replace_in_buffer(from, to) abort
	if filewritable(expand("%")) && search(a:from)
		exec "%s/" . a:from . "/" . a:to . "/gc"
		write
	endif
endfun

