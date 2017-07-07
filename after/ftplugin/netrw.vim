setlocal nonumber
setlocal cursorline

"maybe those functions will get their own place once..

fun! s:preserve_line(action) abort
	let l = line('.')
	return a:action . ":if &filetype == 'netrw' | exec 'normal! " . l . "gg' | endif\<CR>"
endfun

fun! s:get_full_name_under_cursor() abort
	redir => fileinfo
	silent normal qf
	redir end
	let fullname = split(fileinfo)[-1]
	return fullname
endfun

fun! s:copy_path() abort
	call setreg(v:register, s:get_full_name_under_cursor())
	"was it worth it to write a function? Maybe.
endfun

fun! s:change_dir() abort
"	unsilent echom "trying to cd..."
	let fullname = s:get_full_name_under_cursor()
"	unsilent echom "fullname: " . fullname
	let dirname  = fnamemodify(fullname, ':p:h')
	unsilent echom "moving to " . dirname
	unsilent exec "cd " . dirname
endfun

fun! s:is_directory_under_cursor()
	let filename = s:get_full_name_under_cursor()
	if filename[len(filename)-1] == '/'
		return 1
	else
		return 0
	endif
endfun
"an integral part of netrw sidebar
fun! s:open_file()
	if exists('w:is_netrw_sidebar') && w:is_netrw_sidebar
		let g:netrw_browse_split = 4
	else
		let g:netrw_browse_split = 0
	endif
	return s:preserve_line("\<CR>")
endfun

"BECAUSE IT DOESN'T FUCKING WORK
nmap gn <NOP>

"opening node resets cursor position (why?)
"nmap <buffer> <silent> <expr> o <SID>preserve_line("\<CR>")
nmap <buffer> <silent> <expr> o <SID>open_file()
"open in background tab
nmap <buffer> T tgT
"make current folder the new root (a new base, if you will)
nmap <buffer> <silent> B :Ntree<CR>
"try to cd to directory/file under cursor
nmap <buffer> C :<C-U>call <SID>change_dir()<CR>

"disable (slow) incsearch
nnoremap <buffer> / /
nnoremap <buffer> ? ?
"copy full path
nnoremap <buffer> <silent> yy :call <SID>copy_path()<CR>

