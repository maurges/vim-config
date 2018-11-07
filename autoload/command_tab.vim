" See the description in plugin/command_tab.vim

fun! command_tab#tab_behavior()
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
fun! command_tab#shift_tab_behavior()
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
