" Description: a small plugin to comment/uncomment whole lines
" It extracts the comment string from &commentstring and uses it for it's
" devilish purposes
" Oh, and it assumes everything with /**/ comment string also uses //


"the maps
nnoremap <silent> q :exec "s/^\\V\\(".b:cs."\\)\\?/".b:cs."/"<CR>
vnoremap <silent> q <C-C>:exec "'<,'>s/^\\V\\(".b:cs."\\)\\?/".b:cs."/"<CR>
"uncommenting
nnoremap <silent> Q :exec "s/^\\V\\(".b:cs."\\)\\?//"<CR>
vnoremap <silent> Q <C-C>:exec "'<,'>s/^\\V\\(".b:cs."\\)\\?//"<CR>
"setting the string to comment with
augroup commentstring_set
	autocmd!
	autocmd BufWinEnter * call s:set_commentstring()
augroup end
"and the function used in autocmd
fun! s:set_commentstring()
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
