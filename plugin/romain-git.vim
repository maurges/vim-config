" Description: the only two commands I ever used from fugitive, but without
" bloat, taken from romainl's gists

command! -nargs=? Gdiffsplit :call <SID>gdiffsplit(<q-args>)
command! -nargs=0 Gblame :call <SID>gblame()


fun! s:gdiffsplit(spec) abort
	let ft = &l:filetype
	leftabove vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	let cmd = "++edit #"
	if a:spec != ""
		let cmd = "!git -C " . shellescape(fnamemodify(finddir('.git', '.;'), ':p:h:h')) . " show " . a:spec . ":#"
	endif
	execute "read " . cmd
	silent 0d_
	let &l:filetype = ft
	diffthis
	wincmd p
	diffthis
endfun

fun! s:gblame() abort
	let cmd = "!git -C " . shellescape(expand('%:p:h')) . " blame " . expand('%:t')
	echom cmd

	leftabove vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	setlocal nowrap
	vertical resize 40
	execute "read " . cmd
	silent 0d_

	" this shit doesn't work!
	setlocal cursorbind scrollbind
	wincmd p
	let save = getpos(".")
	normal! gg
	setlocal cursorbind scrollbind
	call setpos(".", save)
endfun
