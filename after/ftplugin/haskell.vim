"option for \ before (
setlocal cpoptions+=M

setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal foldmethod=indent

"compiler options
let &l:errorformat = '%\%%(%[a-zA-Z0-9_-]%\+ %#> %\)%\?%f:%l:%v:%m'
if filereadable("./build-remote.json")
	setlocal makeprg=build-remote.py
elseif filereadable("./build-remote.sh")
	setlocal makeprg=./build-remote.sh
elseif filereadable("./build.sh")
	setlocal makeprg=./build.sh
else
	setlocal makeprg=stack\ build\ --fast
endif

"creates quickfix window to the right
augroup haskell_qf
	autocmd!
"	autocmd BufReadPost quickfix exec "normal! \<c-w>L"
augroup end

setlocal grepprg=grep\ -In\ --exclude-dir={.stack-work,_build_debug,_build}\ --exclude=tags\ $*

"try searching for lens-modified record field
nnoremap <silent> <Space>] :exec "tjump /\\C^_\\?" . expand("<cword>") . "$"<cr>

setlocal tags+=.hstags,./.hstags

"generate tag files
command! -nargs=0 HaskellTags !fast-tags -o .hstags -R .

"write tags files
augroup haskell_tags
	autocmd!
	autocmd BufWritePost *.hs	silent! !fast-tags -o .hstags %
augroup END


silent! command! -nargs=0 Format :%!stack exec -- stylish-haskell


iabbrev <buffer> lang# {-# LANGUAGE #-}<left><left><left><left>
iabbrev <buffer> lang_os# {-# LANGUAGE OverloadedStrings #-}
iabbrev <buffer> opt# {-# OPTIONS_GHC #-}<left><left><left><left>


silent! command! -nargs=+ Stack :call <sid>stack_cmd(<q-args>)
fun! s:stack_cmd(str) abort
	let save_mkprg = &l:makeprg
	setlocal makeprg=stack
	exec "make " . a:str
	let &l:makeprg = save_mkprg
endfun

cnoremap <buffer> <expr> ;: <sid>find_cabal()
fun! s:find_cabal() abort
	let path = expand("%:h")
	while len(path) > 3 && path != "." && path != "./"
		echom path
		let names = glob(path . "/*.cabal", v:false, v:true)
		echom string(names)
		if len(names) == 1
			let fname = names[0]
			if filereadable(fname)
				return path
			endif
		endif
		let path = simplify(path . "/..")
	endwhile
	return ""
endfun
