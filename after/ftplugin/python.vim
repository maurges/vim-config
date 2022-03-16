" Determine which python we're using
let b:python_version = 0
if getline(1) =~ 'python3'
	let b:python_version = 3
elseif getline(1) =~ 'python[^3]\?$'
	let b:python_version = 2
endif


"syntax folding doesn't work for some reason
setlocal foldmethod=indent

"some snippets (i should create a little plugin for them)
iabbrev <buffer> main: if __name__ == "__main__":
iabbrev <buffer> header# #!/usr/bin/env python3<CR>from sys import argv
iabbrev <buffer> read_array# map(int, raw_input().strip().split(' '))
iabbrev <buffer> init# def __init__(self,):<left><left>
iabbrev <buffer> init: def __init__(self):

if has('python3')
	setlocal omnifunc=python3complete#Complete
else
	setlocal omnifunc=pythoncomplete#Complete
endif

" set typechecker to appropriate python version
if b:python_version == 2
	setlocal makeprg=mypy\ --check-untyped-defs\ --py2
else
	setlocal makeprg=mypy\ --check-untyped-defs
endif
