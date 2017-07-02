fun! s:preserve_line(action) abort
	let l = line('.')
	return a:action . ":if &filetype == 'netrw' | normal! " . l . "gg | endif\<CR>"
endfun

"opening node resets cursor position (why?)
nmap <buffer> <expr> o <SID>preserve_line("\<CR>")
"open in background tab
nmap <buffer> T tgT
"make current folder the new root (a new base, if you will)
nmap <buffer> B :Ntree<CR>

"disable (slow) incsearch
nnoremap / /
nnoremap ? ?
