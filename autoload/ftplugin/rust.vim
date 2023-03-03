fun! ftplugin#rust#cargo_cmd(str) " no abort
	let save_mkprg = &l:makeprg
	setlocal makeprg=cargo
	exec "make " . a:str
	let &l:makeprg = save_mkprg
endfun
