" Description: a small plugin to comment/uncomment whole lines
" It extracts the comment string from &commentstring and uses it for it's
" devilish purposes
" Oh, and it assumes everything with /**/ comment string also uses //


"the maps
"in normal mode: substitute from current line to current line + count
nnoremap <silent> <Plug>CommentateComment :<C-U>call CommentateNormal(v:count)<CR>
xnoremap <silent> <Plug>CommentateComment :call CommentateVisual<CR>
nnoremap <silent> <Plug>CommentateUncomment :<C-U>call CommentateUncommentNormal(v:count)<CR>
xnoremap <silent> <Plug>CommentateUncomment :call CommentateUncommentVisual(v:count)<CR>

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

fun! CommentateNormal(count) abort
	let firstline = "."
	let lastline = ".+" . a:count
	let cmd = s:prepare_command(firstline, lastline, 1)
	exec cmd
endfun
fun! CommentateVisual(count) range abort
	let cmd = s:prepare_command(a:firstline, a:lastline, 1)
	exec cmd
endfun
fun! CommentateUncommentNormal(count) abort
	let firstline = "."
	let lastline = ".+" . a:count
	let cmd = s:prepare_command(firstline, lastline, 0)
	exec cmd
endfun
fun! CommentateUncommentVisual(count) range abort
	let cmd = s:prepare_command(a:firstline, a:lastline, 0)
	exec cmd
endfun

"maps for me
nmap <BS> <Plug>CommentateComment
xmap <BS> <Plug>CommentateComment
nmap <S-BS> <Plug>CommentateUncomment
xmap <S-BS> <Plug>CommentateUncomment
"other maps for unconfigured terminals
nmap <Leader><BS> <Plug>CommentateUncomment
xmap <Leader><BS> <Plug>CommentateUncomment

"use some nonsense key-combination for terminal
nmap ý <S-BS>
xmap ý <S-BS>


"setting the string to comment with
augroup commentstring_set
	autocmd!
	autocmd BufWinEnter * call s:set_commentstring()
augroup end


"and the function used in autocmd
fun! s:set_commentstring()
	"if someone has already set the cs, use it
	if exists("b:cs")
		return
	endif

	if &filetype == ""
		"use # where unsure
		let b:cs = "#"
 	elseif &commentstring == "/*%s*/"
		"use // for C-style
 		let b:cs = "\\/\\/" "why so many backslashes required?
 	elseif &commentstring == ""
		"use # where unsure V2
 		let b:cs = "#"
 	else
		"extract everything before %s from &commentstr and escape it just in case
 		let b:cs = escape(strpart(&commentstring, 0, match(&commentstring, "%s")), "/\\")
 	endif
endfun
