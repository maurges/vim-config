"airline settings
"disable ugly error sections
let g:airline_section_warning = ''
let g:airline_section_error = ''

let g:airline_theme='raven'

"disable airline for console
if !has("gui_running")
	let g:loaded_airline = 1
else
	"enable some options only in gui
	let g:airline_powerline_fonts=1
	set laststatus=2
endif
