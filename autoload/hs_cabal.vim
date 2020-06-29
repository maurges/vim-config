" Description: Cabal reports errors in a bad way. The path to file is shown
" not from project root, but from cabal file of submodule. This is a fix for
" that.

if !exists("s:lib_paths")
	let s:lib_paths = []
endif


fun! hs_cabal#reset_paths() abort
	let s:lib_paths = []
	call hs_cabal#cabal_autocmd()
endfun


fun! hs_cabal#cabal_autocmd() abort
	if len(s:lib_paths) > 0
		return
	endif
	if !filereadable("./build-remote.sh")
		return
	endif

	let cabal_paths = glob("{source,libs}/**/*.cabal", v:false, v:true)
	let s:lib_paths = map(cabal_paths, {_, x -> fnamemodify(x, ":p:h")})

	augroup hs_cabal_paths_fix
		autocmd!
		autocmd BufNewFile *.hs :call <sid>open_from_path()
	augroup end
endfun


fun! s:open_from_path() abort
	let fname = expand("%")
	echom "finding " . fname
	let save_path = &path
	let &path = join(s:lib_paths, ",")
	try
		exec "find " . fname
	catch /E345/
		echom "bad luck"
	endtry
	let &path = save_path
endfun
