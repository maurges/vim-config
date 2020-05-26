setlocal textwidth=80

compiler cargo
setlocal makeprg=cargo\ build

silent! command! -nargs=+ Cargo :call <sid>cargo_cmd(<q-args>)
fun! s:cargo_cmd(str) abort
	let save_mkprg = &l:makeprg
	setlocal makeprg=cargo
	exec "make " . a:str
	let &l:makeprg = save_mkprg
endfun
