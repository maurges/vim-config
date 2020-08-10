" See description in plugin/completion_aggreg.vim

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


fun! completion_aggreg#complete(findstart, base) abort
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
			try
				let start = function(Func)(1, 0)
				let starts += [[Func, start]]

				if min == -1 || (start >=0 && min > start)
					let min = start
				endif
			catch
				"do nothing
			endtry
		endfor

		if min == -1
			echoerr "CompletionAggreg could not call any function to complete"
		endif

		" as all functions start in different places, but the resulting should
		" start at one, it will manually start them with their bases and add
		" prefix to the result
		let s:prefixes = {}
		let s:bases    = {}

		for [Func, start] in starts
			"as of now i don't completely understand what this line means, but it
			"doesn't include last char, i suppose
			let len  = pos - start
			let base = strpart(line, start, len)
			"don't include last char
			let prlen  = start - min
			let prefix = strpart(line, min, prlen)

			let s:prefixes[Func] = prefix
			let s:bases[Func]    = base
		endfor

		return min

	else
		" SECOND INVOCATION

		let matches = []

		for Func in b:funcs
			try

				let base = s:bases[Func]
				let prefix = s:prefixes[Func]
				if base == ""
					" Some functions may create a bad completion and pollute the results
					" with a lot of garbage. This is a way to trim that garbage
					let base = a:base
				endif

				if exists('r') | unlet r | endif

				let r = function(Func)(0, base)

				if type(r) == type([])
					let pre_words = r
				elseif type(r) == type({})
					let pre_words = r.words
				else
					echo "pre_words: "
					echo r
					echoerr "^^^ unexpected type of return value"
				endif

				let words = s:strings2dicts(pre_words, 'word')

				"modify returned words: add prefix to each word and run some function on
				"each (currently it removes opening bracket)
				for word in words
					let word.word = prefix . word.word
					let word.word = s:post_change_word(word.word)
				endfor

				let matches += words

			catch
				"do nothing
			endtry
		endfor

		return {'words' : matches}

	endif
endfun


fun! s:post_change_word(word) abort
	"strip the word of opening bracket
	if len(a:word) > 0 && a:word[len(a:word)-1] == '('
		return a:word[0:-2]
	endif
	return a:word
endfun


" convert list of strings to list of dicts if it is indeed of strings
fun! s:strings2dicts(arr, key) abort
	if len(a:arr) == 0
		return []
	endif

	if type(a:arr[0]) == type({})
		return a:arr
	endif

	let r = []
	for i in a:arr
		let r += [{a:key : i}]
	endfor
	return r
endfun
