" Description: This plugin serves two purposes. One is to redraw the screen
" when tab was pressed in command line. The other is to go to the next match
" when tab is pressed in search prompt


fun! TabBehavior()
	" if in search prompt
	if getcmdtype() =~ '[\/?]'
		" return hotkey which sends you to next occurence
		return "\<C-G>"
	else
		" when completing in command line, redraw the screen
		redraw
		" and return the key for completing
		return nr2char(&wcm)
	endif
endfun
fun! ShiftTabBehavior()
	" if in search prompt
	if getcmdtype() =~ '[\/?]'
		" return hotkey which sends you to next occurence
		return "\<C-T>"
	else
		" do not redraw the screen when pressing shift-tab
		" and return the key for completing
		return nr2char(&wcm)
	endif
endfun
cnoremap <expr> <tab> TabBehavior()
cnoremap <expr> <s-tab> ShiftTabBehavior()
