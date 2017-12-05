" Description: plugin to enhance my quickfix usage
"              Main feature is entering quickfix mode, where each tab has a
"              quickfix window that opens automatically

" It turned out with syntastic that I now more often use localist instead of
" quickfix list, so this enhances the use of this plugin

command! QuickfixWinOpen  :call <SID>win_open()
command! QuickfixWinClose :call <SID>win_close()


let g:quickfix_use_loc_list = 1
fun! s:use_loc_list()
	if exists('b:quickfix_use_loc_list')
		if b:quickfix_use_loc_list
			return 1
		else
			return 0
		endif
	else "not exists
		if g:quickfix_use_loc_list
			return 1
		else
			return 0
		endif
	endif
endfun

fun! s:win_open()
	if s:use_loc_list()
		lopen
	else
		copen
	endif
endfun
fun! s:win_close()
	if s:use_loc_list()
		lclose
	else
		cclose
	endif
endfun

fun! EnterQuickfix()
	"signal about entering
	let g:quickfix_enabled = 1

	"remember where we were
	let c_tab_nr = tabpagenr()

	"open window and leave it
	tabdo exec "QuickfixWinOpen | wincmd p"

	"return to where we were
	exec "normal! " . c_tab_nr . "gt"
endfun

fun! LeaveQuickfix()
	"signal about leaving
	unlet g:quickfix_enabled
	
	"remember where we were
	let c_tab_nr = tabpagenr()

	tabdo QuickfixWinClose

	"return to where we were
	exec "normal! " . c_tab_nr . "gt"
endfun


"open a a qf window if mode is enabled
fun! s:on_tab_enter() abort
	if !exists('t:quickfix_entered') && exists('g:quickfix_enabled')
		"open and leave
		QuickfixWinOpen
		wincmd p
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
		if s:use_loc_list()
			lclose
		else
			cclose
		endif
	endif
endfun


"commands for functions above
command! EnterQuickfix :call EnterQuickfix()
command! LeaveQuickfix :call LeaveQuickfix()


"maps to move between appropriate errors
nnoremap <expr> <silent> <C-N> <SID>use_loc_list() ? ":lnext\<CR>" : ":cnext\<CR>"
nnoremap <expr> <silent> <C-P> <SID>use_loc_list() ? ":lprev\<CR>" : ":cprev\<CR>"
