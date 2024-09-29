fun! ftplugin#rust#cargo_cmd(str) " no abort
	let save_mkprg = &l:makeprg
	setlocal makeprg=cargo
	try
		exec "make " . a:str
	finally
		let &l:makeprg = save_mkprg
	endtry
endfun
