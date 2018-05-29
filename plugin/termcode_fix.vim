" Description: vanilla vim has some shit with pressing some keys starting with
" esc. As i use esc for my mappings, it breaks and deletes my files. So i map
" this sequence to tame it a bit

if has('nvim') || has('gui')
	finish
endif

"main fixer
noremap <expr> <Esc>[ <SID>termcodes_fix()
fun! s:termcodes_fix()
	echo "fixing termcode shit..."
	let c = nr2char(getchar())
	while c != 'c' && c != "\<c-c>"
		let c = nr2char(getchar())
	endwhile
	echo ""
	return ''
endfun

" also there are some mappings i would like to get rid of
unmap <Esc>[3~
