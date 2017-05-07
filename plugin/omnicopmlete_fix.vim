" Description: an omnicompletion fix: inserts a closing bracket when text has opening one

"remaps to set a guard
imap <C-x><C-o> <C-r>=<SID>close_paren()<CR><C-x><C-o>

"after completion ended closes the bracket if necessary
fun! s:perform_paren_closing(completed_item) abort
	"if there was word completed and it ended in (
	if has_key(a:completed_item, "word") && a:completed_item.word =~# '($'
		"insert a bracket and go before it
		call feedkeys(")\<Left>", 'in')
	endif
	"clear the autocommands
	autocmd! close_paren
	augroup! close_paren
endfun

"simply place a guard to close bracket after completion ended
fun! s:close_paren() abort
    augroup close_paren
        autocmd!
        autocmd CompleteDone <buffer> call <SID>perform_paren_closing(v:completed_item)
    augroup END
    return ''
endfun

