" See plugin/commentate.vim for description

"argument tells whether to insert or delete commentstring
fun! s:prepare_command(first_line, last_line, insert) abort
	"range
	let cmd = a:first_line . "," . a:last_line
	"substitute, absolutely no magic
	let cmd .= "s/^\\V"
	"maybe comment string
	let cmd .= "\\(" . b:cs . "\\)\\?"
	"substitute separator
	let cmd .= "/"
	"with commentstring or with nothing
	if a:insert
		let cmd .= b:cs
	endif
	"substitute end
	let cmd .= "/"

	return cmd
endfun

fun! commentate#CommentateNormal(count) abort
	let firstline = "."
	let lastline = ".+" . (a:count - 1)
	let cmd = s:prepare_command(firstline, lastline, 1)
	exec cmd
endfun
fun! commentate#CommentateVisual() range abort
	let cmd = s:prepare_command(a:firstline, a:lastline, 1)
	exec cmd
endfun
fun! commentate#CommentateUncommentNormal(count) abort
	let firstline = "."
	let lastline = ".+" . (a:count - 1)
	let cmd = s:prepare_command(firstline, lastline, 0)
	exec cmd
endfun
fun! commentate#CommentateUncommentVisual() range abort
	let cmd = s:prepare_command(a:firstline, a:lastline, 0)
	exec cmd
endfun
