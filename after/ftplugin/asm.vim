setlocal commentstring=;%s
setlocal tabstop=10
setlocal shiftwidth=10

setlocal foldmethod=marker

nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>

inoremap <buffer> <expr> <S-CR> <SID>embrace()

fun! s:embrace()
	let cmdstart = "\<C-C>"
	let l = getline(line('.'))
	if l =~ "^defsub"
		return cmdstart . "0wywO; \<C-R>\" {{{\<C-C>joendsub\<CR>; }}}\<C-C>kO\<Tab>"
	elseif l =~ "^defun"
		return cmdstart . "0wywO; \<C-R>\" {{{\<C-C>joendfun\<CR>; }}}\<C-C>kO\<Tab>"
	elseif l =~ "^%macro"
		return cmdstart . "o%endmacro\<C-C>O    "
	elseif l =~ "^; .* {{{"
		return cmdstart . "o; }}}\<C-C>O"
	else
		return "\<CR>"
	endif
endfun
