" Description: a small function to copy ths buffer in new tab, similar to
" :wincmd T, but instead of destroying old window, it keeps it

fun! TabCopyBuffer() abort
	let buf = bufnr("%")
	tabnew
	exec "buffer " . buf
endfun

" i suggest current mapping for this (as it is in my vimrc):
"nnoremap <C-W>t :call TabCopyBuffer()<CR>
" where 't' stands for 'tab'
