"syntax folding doesn't work for some reason
setlocal foldmethod=indent

"some snippets (i should create a little plugin for them)
iabbrev <buffer> main: if __name__ == "__main__":
iabbrev <buffer> header# #!/usr/bin/env python3<CR>from sys import argv
iabbrev <buffer> read_array# map(int, raw_input().strip().split(' '))

if has('python3')
	setlocal omnifunc=python3complete#Complete
else
	setlocal omnifunc=pythoncomplete#Complete
endif

"set syntastic checker for appropriate python
fun! PythonSetSyntasticChecker()
	if getline(1) =~ 'python3'
		let g:syntastic_python_python_exec = '/usr/bin/python3'
	elseif getline(1) =~ 'python[^3]\?$'
		let g:syntastic_python_python_exec = '/usr/bin/python2'
	endif
	return ""
endfun

call PythonSetSyntasticChecker()
nnoremap <expr> <Leader>sc PythonSetSyntasticChecker()
