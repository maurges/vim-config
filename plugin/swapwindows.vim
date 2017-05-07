" Description: a small function to swap current and previous windows' places

" stay declares whether to stay in the previous window or not
fun! Swap_window_with_prev(stay) abort
	"obtain current buffer and window ids
	let cbuf = bufnr("%")
	let cwin = winnr()
	"go to previous buffer
	exec "normal! \<c-w>p"
	"obtain ids again
	let prevbuf = bufnr("%")
	let prevwin = winnr()
	exec "buffer " . cbuf
	"go to window where we started
	exec cwin . "wincmd w"
	exec "buffer " . prevbuf
	"return to previous window if should stay
	if a:stay
		exec prevwin . "wincmd w"
	endif
endfun

" i suggest current mapping (as it is in my vimrc):
"nnoremap <C-W>a :call Swap_window_with_prev(0)<CR>
" where 'a' in mapping stands for 'alternate'
