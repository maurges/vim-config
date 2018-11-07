" Description: when completion is invoked, it will go through all completion
" sources and aggregate them into one. Behaves as usercomplete function
" Completion sources are: omnifunc and list of other functions

let s:debug = 0

"list of names of completion functions
if !exists('g:completion_aggreg_functions')
	let g:completion_aggreg_functions = []
endif
