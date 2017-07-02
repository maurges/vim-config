fun! s:preserve_line(action) abort
	let l = line('.')
	return a:action . ":if &filetype == 'netrw' | exec 'normal! " . l . "gg' | endif\<CR>"
endfun

fun! s:change_dir() abort
	unsilent echom "trying to cd..."
	redir => fileinfo
	silent normal qf
	redir end
	let fullname = split(fileinfo)[-1]
	unsilent echom "fullname: " . fullname
	let dirname  = fnamemodify(fullname, ':p:h')
	unsilent echom "moving to " . dirname
	unsilent exec "cd " . dirname
endfun

"opening node resets cursor position (why?)
nmap <silent> <buffer> <expr> o <SID>preserve_line("\<CR>")
"open in background tab
nmap <buffer> T tgT
"make current folder the new root (a new base, if you will)
nmap <silent> <buffer> B :Ntree<CR>
"try to cd to directory/file under cursor
nmap <buffer> C :call <SID>change_dir()<CR>

"disable (slow) incsearch
nnoremap <buffer> / /
nnoremap <buffer> ? ?
