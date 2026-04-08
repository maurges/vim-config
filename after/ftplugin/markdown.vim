fun! MarkdownFold(line) abort
	" Detect code blocks, as they can contain heading starter symbols
	for syntax in synstack(a:line, 1)
		if synIDattr(syntax, "name") == "markdownCodeBlock"
			return "="
		endif
	endfor
	" Emit fold markers equal to the heading level
	let line = getline(a:line)
	let m = matchlist(line, '^\s*\(#\+\)')
	if len(m) != 0
		return ">" . len(m[1])
	endif
	return "="
endfun

setlocal foldmethod=expr
setlocal foldexpr=MarkdownFold(v:lnum)
