setlocal commentstring=;%s
setlocal tabstop=10
setlocal shiftwidth=10

setlocal textwidth=78

setlocal foldmethod=marker

nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>

xnoremap <buffer> <Leader>s <C-C>`<O; {{{<Esc>`>o; }}}<Esc>
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
	elseif l =~ "; .* {{{"
		return cmdstart . "o; }}}\<C-C>O"
	elseif l =~ "section \..*"
		return cmdstart . "$yiwo; \<C-R>\" {{{\<CR>\<CR>; }}}\<C-C>kO"
	elseif l =~ "%ifndef [A-Z_]*"
		return cmdstart . "0wwywo%define \<C-R>\"\<CR>\<CR>\<CR>\<CR>%endif\<C-C>kkA"
	elseif l =~ '^\k\+:'
		return cmdstart . "0yiwO; \<C-R>\" {{{\<C-C>jo; }}}\<C-C>O\<Tab>"
	else
		return "\<CR>"
	endif
endfun
