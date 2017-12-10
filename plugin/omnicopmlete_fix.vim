" Description: an omnicompletion fix: inserts a closing bracket when text has opening one

"remaps to set a guard
inoremap <C-x><C-o> <C-r>=<SID>close_paren()<CR><C-x><C-o>

"after completion ended closes the bracket if necessary
fun! s:perform_paren_closing() abort
	if !exists('v:completed_item')
		echom "Could not fix omnicompletion: no item or vim doesn't support v:completed_item"
		return
	endif
	"clear the autocommands
	autocmd! close_paren
	augroup! close_paren
	"if there was word completed and it ended in (
	if has_key(v:completed_item, "word") && v:completed_item.word =~# '($'
		"insert a bracket and go before it
		call feedkeys(")\<Left>", 'in')
	endif
	return
endfun

"simply place a guard to close bracket after completion ended
fun! s:close_paren() abort
	augroup close_paren
		autocmd!
		autocmd CompleteDone <buffer> call <SID>perform_paren_closing()
	augroup END
	return ''
endfun
