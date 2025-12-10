" Description: the only two commands I ever used from fugitive, but without
" bloat, taken from romainl's gists

command! -nargs=* Gdiffsplit :call <SID>gdiffsplit(<f-args>)
command! -nargs=0 Gblame :call <SID>gblame()

fun! s:gdiffsplit(...) abort
	let spec = ""
	if a:0 >= 1
		let spec = a:1
	endif

	let file_path_full = expand("%:p")
	let repo_path = fnamemodify(finddir('.git', '.;'), ':p:h:h')
	let file_path = file_path_full[len(repo_path)+1:]
	if a:0 == 2
		let file_path = a:2
	endif

	let ft = &l:filetype

	leftabove vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	let cmd = "++edit #"
	if spec != ""
		let cmd = "!git -C " . shellescape(repo_path) . " show " . spec . ":" . shellescape(file_path)
	endif
	execute "read " . cmd
	silent 0d_
	let &l:filetype = ft
	diffthis
	wincmd p
	diffthis
endfun

fun! s:gblame() abort
  " a hack to fix scrollbind. This works, but fucks up scroll position
	let save = getpos(".")
	normal! gg

	let cmd = "git -C " . shellescape(expand('%:p:h')) . " blame --line-porcelain " . expand('%:t')
	let git_output = system(cmd)
	let chunks = split(git_output, "\t[^\n]*\\zs\n")
	" map each chunk to an ouptut line
	let output = []
	for chunk in chunks
		let fields = split(chunk, "\n")
		let commit = fields[0][0:8]
		" first is commit id, last is line itself. Rest is fields with names
		let fields = fields[1:-2]
		let fs = {}
		for field in fields
			let space_pos = stridx(field, " ")
			let name = field[:space_pos-1]
			let val = field[space_pos+1:]
			let fs[name] = val
		endfor
		let s = commit .. " " .. fs["committer"] .. "(" .. strftime("%Y %b %d", fs["committer-time"]) .. "): " .. fs["summary"]
		let output += [s]
	endfor

	leftabove vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	setlocal nowrap
	vertical resize 40
	call append(0, output)
	silent $d_

	" right now we're in the split with blame output
	normal! gg
	setlocal cursorbind scrollbind
	wincmd p
	setlocal cursorbind scrollbind
  " we did gg in the original split at the start of this function
	call setpos(".", save)
endfun
