" Description: when completion is invoked, it will go through all completion
" sources and aggregate them into one. Behaves as usercomplete function
" Completion sources are: omnifunc and list of other functions

"list of names of completion functions
if !exists('g:completion_aggreg_functions')
	let g:completion_aggreg_functions = []
endif

"returns complete functions local for buffer
fun! s:local_funcs() abort
	let fns = []
	if exists('b:completion_aggreg_functions')
		let fns += b:completion_aggreg_functions
	else
		let fns += g:completion_aggreg_functions
	endif
	if &omnifunc != ""
		let fns += [&omnifunc]
	endif
	return fns
endfun


fun! CompletionAggreg(findstart, base) abort
	if a:findstart
		" FISRT INVOCATION
		let pos  = col('.') - 1
		let line = getline(line('.'))

		"set functions for buffer
		let b:funcs = s:local_funcs()

		let starts = []
		let min    = -1

		"initialize them all and find minimum
		for Func in b:funcs
			let start = function(Func)(1, 0)
			let starts += [[Func, start]]

			if min == -1 || min > start
				let min = start
			endif
		endfor

		" as all functions start in different places, but the resulting should
		" start at one, it will manually start them with their bases and add
		" prefix to the result
		let s:prefixes = {}
		let s:bases    = {}

		for [Func, start] in starts
			"include both ends
			let len  = pos - start + 1
			let base = strpart(line, start, len)
			"don't include last char
			let prlen  = start - min
			let prefix = strpart(line, min, prlen)

			let s:prefixes[Func] = prefix
			let s:bases[Func]    = base
		endfor

		return min

	else

		let matches = []

		" SECOND INVOCATION
		for Func in b:funcs

			let base = s:bases[Func]
			let prefix = s:prefixes[Func]

			let words = s:strings2dicts(function(Func)(0, base).words, 'word')

			"add prefix to each word
			for word in words
				let word.word = prefix . word.word
			endfor

			let matches += words

		endfor

		return {'words' : matches}

	endif
endfun


" convert list of strings to list of dicts if it is indeed of strings
fun! s:strings2dicts(arr, key) abort
	if type(a:arr[0]) == type({})
		return a:arr
	endif

	let r = []
	for i in a:arr
		let r += [{a:key : i}]
	endfor
	return r
endfun
