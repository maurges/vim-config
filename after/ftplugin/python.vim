"syntax folding doesn't work for some reason
setlocal foldmethod=indent

"some snippets (i should create a little plugin for them)
iabbrev <buffer> main: if __name__ == "__main__":
iabbrev <buffer> header# #!/usr/bin/env python3<CR>from sys import argv
iabbrev <buffer> read_array# map(int, raw_input().strip().split(' '))
iabbrev <buffer> init# def __init__(self,):<left><left>
iabbrev <buffer> init: def __init__(self):

setlocal omnifunc=python3complete#Complete

" set typechecker to appropriate python version
if executable("mypy")
	setlocal makeprg=mypy\ --check-untyped-defs
elseif executable("ty")
	setlocal makeprg=ty\ check\ --output-format=concise
endif
