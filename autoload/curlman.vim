" See ../plugin/curlman.vim

if !exists("s:last_output_number")
	let s:last_output_number = 0
endif

fun! s:ensure_env_sourced() abort
	if !g:curlman_did_source_env
		for file in ["./curlman.vim", "./curlman/env.vim"]
			if filereadable(file)
				exec "source " .. file
				let g:curlman_did_source_env = v:true
				" do not return as we might want to source many files
			endif
		endfor
	endif
endfun

" Create new scratch window and switch to it
" @returns window id of the created window
fun! s:new_scratch_window() abort
	let bufname = "[output " .. s:last_output_number .. "]"
	let s:last_output_number += 1
	rightbelow vertical new
	setlocal bufhidden=wipe buftype=nofile noswapfile
	exec "file " .. bufname
	return bufwinid("%")
endfun

" Switch to the scratch window for the current tab, or create a new if it
" doesn't exist
fun! s:switch_to_buffer() abort
	if !exists("t:curlman_output_buffer")
		let t:curlman_output_buffer = s:new_scratch_window()
	else
		let success = win_gotoid(t:curlman_output_buffer)
		"may fail if the user has closed the scratch buffer
		if !success
			let t:curlman_output_buffer = s:new_scratch_window()
		endif
	endif
endfun

" attempt to format current buffer as a detected format
fun! s:format() abort
	"break undo
	let &undolevels = &undolevels

	"try to format json
	silent! %!python3 -m json.tool
	if v:shell_error != 0
		undo
	else
		setlocal filetype=json
		return
	endif

	"maybe other formatters?
	setlocal filetype=
endfun

" like system(), but collect stdout and stderr separately. Prints stderr as it
" arrives, and returns both streams in full
fun! s:system(cmd) abort
	let out = []
	" use buffered stdout to bypass the problem below
	" help channel-lines
	let err = [""]
	fun! s:on_err(j, data, n) abort closure
		let last_index = len(err) - 1
		let err[-1] .= a:data[0]
		call extend(err, a:data[1:])
		if len(a:data) > 0
			echo join(err[last_index:], "\n")
		endif
	endfun

	let opts = {}
	let opts["on_stdout"] = {j,d,n->extend(out, d)}
	let opts["on_stderr"] = function("\<sid>on_err")
	let opts["stdout_buffered"] = v:true
	let id = jobstart(a:cmd, opts)
	call jobwait([id])

	" for some reason it inserts an empty line there
	if len(out) > 0 && out[-1] == ""
		call remove(out, -1)
	endif
	return [out, err]
endfun

" struct ParseResult
" { is_script :: Bool
" , sets_expressions :: [(String, String)]
" }

" Remove comments from input, and parse metadata from comments
" :: [String] -- ^ lines of file to parse
" -> ( [String] -- ^ remaining file lines
"    , ParseResult
"    )
fun! s:parse_lines(lines) abort
	let lines = copy(a:lines)
	let r = #{is_script: v:false, sets_expressions: []}

	if lines[0] =~ '^#!'
		let r.is_script = v:true
	endif

	"remove comments
	let comments = []
	let i = 0
	while i < len(lines)
		if a:lines[i] =~ '\m^\s*#'
			call add(comments, remove(lines, i))
		else
			let i += 1
		endif
	endwhile

	for line in comments
		let pos = match(line, '\m^\s*#\s* curlman:\zs')
		if pos == -1 | continue | endif
		let command = line[pos:]
		let m = matchlist(command, '\m\s*sets\s\+\(\$\?\w\+\)\s*=\s*\(.\+\)')
		if m == [] | continue | endif
		call add(r.sets_expressions, [m[1], m[2]])
	endfor

	return [lines, r]
endfun

" Run expressions that set variables after program output. The expressions
" were previously parsed from special program comments.
" The expressions use current buffer as stdin
fun! s:run_sets(sets) abort
	let fname = tempname()
	silent exec "write " .. fname
	for [varname, expr] in a:sets
		let [out, err] = s:system("<" .. fname .. " " .. expr)
		if len(out) == 0
			echoerr "No output of expression " .. expr
		endif
		if len(out) == 1
			let resulting = trim(out[0])
		else
			let resulting = join(out, "\n")
		endif
		exec "let " .. varname .. " = resulting"
	endfor
endfun

fun! curlman#run_in_file() abort
	call s:ensure_env_sourced()

	let lines = getline(1, "$")
	let [lines, meta] = s:parse_lines(lines)

	" full path to current file
	let command = [expand("%:p")]
	" or just current file itself
	if !meta.is_script
		" join with backslashes or not, depending if first line has them
		let command = lines[0] =~ '\m\\$'
			\ ? join(lines, "\n")
			\ : join(lines, "\\\n")
	endif

	let [output, errors] = s:system(command)
	if output == [] || output == [""]
		let output = errors
	endif

	let old_window = win_getid()
	call s:switch_to_buffer()
	let old_output_pos = getpos(".")
	call deletebufline("%", 1, "$")
	call setline(1, output)

	call s:run_sets(meta.sets_expressions)

	call s:format()
	call setpos(".", old_output_pos)
	if !g:curlman_switch_to_result
		call win_gotoid(old_window)
	endif
endfun

" Created by xolox, public domain
fun! curlman#get_visual_selection()
	" Why is this not a built-in Vim script function?!
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction

fun! curlman#set_env(varname, value) abort
	let temp = a:value
	exec "let $" .. a:varname .. " = temp"
endfun

