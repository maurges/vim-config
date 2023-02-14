" indent plugin inserts two shiftwidths instead of one tab, so i set it so low
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal suffixesadd=.sty,.tex,.cls
setlocal iskeyword+=:

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
elseif filereadable("./default.nix")
	setlocal makeprg=nix-build
else
	setlocal makeprg=make
endif


" complex fold expression for sections and begins-ends
let s:begin_regex = '\(\\\)\@<!\\begin{'
let s:end_regex = '\(\\\)\@<!\\end{'
fun! TexFold(line) abort
	let line = getline(a:line)
	if line =~ '^\s*\\section'
		return ">1"
	elseif line =~ '^\s*\\subsection'
		return ">2"
	elseif line =~ '^\s*\\subsubsection'
		return ">3"
	elseif line =~ s:begin_regex
		if line =~ s:end_regex
			"no fold here
			return "="
		else
			return "a1"
		endif
	elseif line =~ s:end_regex
		return "s1"
	endif
	return "="
endfun

setlocal foldmethod=expr
setlocal foldexpr=TexFold(v:lnum)
