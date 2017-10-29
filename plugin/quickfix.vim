" Description: plugin to enhance my quickfix usage
"              Main feature is entering quickfix mode, where each tab has a
"              quickfix window that opens automatically


fun! EnterQuickfix()
	"signal about entering
	let g:quickfix_enabled = 1

	"remember where we were
	let c_tab_nr = tabpagenr()

	"open window and leave it
	tabdo exec "copen | normal! \<c-w>p"

	"return to where we were
	exec "normal! " . c_tab_nr . "gt"
endfun

fun! LeaveQuickfix()
	"signal about leaving
	unlet g:quickfix_enabled
	
	"remember where we were
	let c_tab_nr = tabpagenr()

	tabdo cclose

	"return to where we were
	exec "normal! " . c_tab_nr . "gt"
endfun


"open a a qf window if mode is enabled
fun! s:on_tab_enter() abort
	if !exists('t:quickfix_entered') && exists('g:quickfix_enabled')
		"open and leave
		copen
		exec "normal! \<c-w>p"
		"remember this tab was visited
		let t:quickfix_entered = 1
	endif
endfun


"on creating a new window, execute function above
augroup quickfix_on_new_tab
	autocmd!
	autocmd TabEnter * call <SID>on_tab_enter()
augroup END

"on closing a window, close the quickfix if only it was left
augroup quickfix_closer
	autocmd!
	autocmd BufEnter * call <SID>close_qf()
augroup END
fun! s:close_qf()
	if winnr("$") == 1 && &buftype == "quickfix"
		cclose
	endif
endfun


"commands for functions above
command! EnterQuickfix :call EnterQuickfix()
command! LeaveQuickfix :call LeaveQuickfix()
