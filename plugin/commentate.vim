" Description: a small plugin to comment/uncomment whole lines
" It extracts the comment string from &commentstring and uses it for it's
" devilish purposes
" Oh, and it assumes everything with /**/ comment string also uses //


"the maps
"in normal mode: substitute from current line to current line + count
"supplied, changing the initial comment string or nothing to commentstring
nnoremap <silent> <Plug>CommentateComment :<C-U>exec ".,.+" . (v:count - 1) ."s/^\\V\\(".b:cs."\\)\\?/".b:cs."/"<CR>
"similar in insert mode, but substitute over range supplied
vnoremap <silent> <Plug>CommentateComment <C-C>:exec "'<,'>s/^\\V\\(".b:cs."\\)\\?/".b:cs."/"<CR>
"uncommenting: similar to commenting, but substitute to nothing
nnoremap <silent> <Plug>CommentateUncomment :<C-U>exec ".,.+" . (v:count - 1) ."s/^\\V\\(".b:cs."\\)\\?//"<CR>
vnoremap <silent> <Plug>CommentateUncomment <C-C>:exec "'<,'>s/^\\V\\(".b:cs."\\)\\?//"<CR>

"maps for me
nmap <BS> <Plug>CommentateComment
vmap <BS> <Plug>CommentateComment
nmap <S-BS> <Plug>CommentateUncomment
vmap <S-BS> <Plug>CommentateUncomment

"use some nonsense key-combination for terminal
nmap ý <S-BS>
vmap ý <S-BS>


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
