" Description: plugin to enhance my quickfix usage
"              Main feature is entering quickfix mode, where each tab has a
"              quickfix window that opens automatically

" It turned out with syntastic that I now more often use localist instead of
" quickfix list, so this enhances the use of this plugin

command! -nargs=0  QuickfixWinOpen    :call <SID>win_open()
command! -nargs=0  QuickfixWinClose   :call <SID>win_close()

command! -nargs=?  QuickfixUseLocList :call <SID>command_set_loc_list(<args>)
command! -nargs=0  Quickfixqf         :QuickfixUseLocList 0
command! -nargs=0  Quickfixloc        :QuickfixUseLocList 1

let g:quickfix_use_loc_list = -1

fun! s:command_set_loc_list(...) abort
	"set to use
	if a:0 == 1
		let g:quickfix_use_loc_list = a:1
		return
	endif
	"print it
	if exists('b:quickfix_use_loc_list')
		if b:quickfix_use_loc_list
			echo "locally loc list"
		else
			echo "locally quickfix"
		endif
	else "not exists
		if g:quickfix_use_loc_list
			echo "globally set loc list"
		else
			echo "globally set quickfix"
		endif
	endif
endfun

fun! s:use_loc_list_var() abort
	if exists('b:quickfix_use_loc_list')
		return s:use_loc_list(b:quickfix_use_loc_list)
	else
		return s:use_loc_list(g:quickfix_use_loc_list)
	endif
endfun

fun! s:use_loc_list(loc_mode) abort
	if a:loc_mode == 1
		return 1
	elseif a:loc_mode == 0
		return 0
	else
		return getqflist() == []
	endif
endfun


fun! s:win_open() "noabort
	if s:use_loc_list()
		lopen
	else
		copen
	endif
	"and go to last screen
	wincmd p
endfun
fun! s:win_close() "noabort
	if s:use_loc_list()
		lclose
	else
		cclose
	endif
endfun

fun! EnterQuickfix() abort
	"signal about entering
	let g:quickfix_enabled = 1

	"remember where we were
	let c_tab_nr = tabpagenr()

	"open window and leave it
	tabdo exec "QuickfixWinOpen"

	"return to where we were
	exec "normal! " . c_tab_nr . "gt"
endfun

fun! LeaveQuickfix() abort
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
		"remember this tab was visited
		let t:quickfix_entered = 1
	endif
endfun
"close quickfix or loclist window if it's the last left in tab
fun! s:close_qf()
	if winnr("$") == 1 && &buftype == "quickfix"
		if s:use_loc_list()
			lclose
		else
			cclose
		endif
	endif
endfun


"on creating a new window, open quickfix window if mode is set
augroup quickfix_on_new_tab
	autocmd!
	autocmd TabEnter * call <SID>on_tab_enter()
augroup END

"on closing a window, close the quickfix if only it was left
augroup quickfix_closer
	autocmd!
	autocmd BufEnter * call <SID>close_qf()
augroup END


"commands for functions above
command! -nargs=0  EnterQuickfix :call EnterQuickfix()
command! -nargs=0  LeaveQuickfix :call LeaveQuickfix()


"maps to move between appropriate errors
nnoremap <expr> <silent> <C-N> <SID>use_loc_list_var() ? ":lnext\<CR>" : ":cnext\<CR>"
nnoremap <expr> <silent> <C-P> <SID>use_loc_list_var() ? ":lprev\<CR>" : ":cprev\<CR>"
