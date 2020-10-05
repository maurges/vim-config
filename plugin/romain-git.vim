" Description: the only two commands I ever used from fugitive, but without
" bloat, taken from romainl's gists

command! -nargs=? Gdiffsplit :call <SID>gdiffsplit(<q-args>)
command! -nargs=0 Gblame :call <SID>gblame()


fun! s:gdiffsplit(spec) abort
	let ft = &l:filetype
	let file_path_full = expand("%:p")

	leftabove vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	let cmd = "++edit #"
	if a:spec != ""
		let repo_path = fnamemodify(finddir('.git', '.;'), ':p:h:h')
		let file_path = file_path_full[len(repo_path)+1:]
		let cmd = "!git -C " . shellescape(repo_path) . " show " . a:spec . ":" . shellescape(file_path)
	endif
	execute "read " . cmd
	silent 0d_
	let &l:filetype = ft
	diffthis
	wincmd p
	diffthis
endfun

fun! s:gblame() abort
	let cmd = "!git -C " . shellescape(expand('%:p:h')) . " annotate " . expand('%:t')
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
