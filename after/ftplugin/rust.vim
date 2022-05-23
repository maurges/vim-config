setlocal textwidth=80

compiler cargo
setlocal makeprg=cargo\ build

setlocal grepprg=grep\ -In\ --exclude-dir=target\ --exclude=.rstags\ $*

setlocal tags +=.rstags,./.rstags
"generate tag files
command! -nargs=0 RustTags !ctags --exclude=target -o .rstags -R .
"write tags files
augroup rust_tags
	autocmd!
	autocmd BufWritePost *.rs	silent! !ctags -o .rstags %
augroup END


silent! command! -nargs=+ Cargo :call <sid>cargo_cmd(<q-args>)
fun! s:cargo_cmd(str) " no abort
	let save_mkprg = &l:makeprg
	setlocal makeprg=cargo
	exec "make " . a:str
	let &l:makeprg = save_mkprg
endfun
