fun! MarkdownFold(line) abort
	let line = getline(a:line)
	let m = matchlist(line, '^\s*\(#\+\)')
	if len(m) != 0
		return ">" . len(m[1])
	endif
	return "="
endfun

setlocal foldmethod=expr
setlocal foldexpr=MarkdownFold(v:lnum)
