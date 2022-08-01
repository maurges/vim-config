" Description: this used to be a plugin for IDE-like quickfix, but I never
" used it. So I'm only keeping the keybinds.

"on closing a window, close the quickfix if only it was left
fun! s:close_qf()
	if winnr("$") == 1 && &buftype == "quickfix"
		quit
	endif
endfun
augroup quickfix_closer
	autocmd!
	autocmd BufEnter * call <SID>close_qf()
augroup END


fun! s:use_loc_list() abort
	return len(getloclist(0)) != 0
endfun
"maps to move between appropriate errors
nnoremap <expr> <silent> <C-N> <SID>use_loc_list() ? ":lnext\<CR>" : ":cnext\<CR>"
nnoremap <expr> <silent> <C-P> <SID>use_loc_list() ? ":lprev\<CR>" : ":cprev\<CR>"
