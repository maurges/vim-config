" indent plugin inserts two shiftwidths instead of one tab, so i set it so low
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal suffixesadd=.sty,.tex,.cls
setlocal iskeyword+=:

setlocal foldmethod=marker
setlocal foldmarker=[[[,]]]

xnoremap <buffer> <Leader>s <C-C>`<O% [[[<Esc>`>o% ]]]<Esc>
inoremap <buffer> <expr> <S-CR> <SID>embrace()

fun! s:embrace()
	let cmdstart = "\<C-C>"
	let l = getline(line('.'))
	if l =~ '.*\\begin{.\+}'
		return cmdstart . "yyp$F\\lceend\<C-C>O"
	else
		return "\<CR>"
	endif
endfun

iabbrev -и \item

"compiler options
if filereadable("./build-remote.json")
	setlocal makeprg=build-remote.py
elseif filereadable("./build-remote.sh")
	setlocal makeprg=./build-remote.sh
elseif filereadable("./build.sh")
	setlocal makeprg=./build.sh
else
	setlocal makeprg=make
endif
