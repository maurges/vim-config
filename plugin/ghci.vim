"Description: plugin to communicate with the ghci process in terminal window.
" I mainly use it to five type and location info

if !exists("s:bufid")
  let s:bufid = -1
endif
let s:start_cmd = "runghci.bat"

" Maintenance functions

fun! SetBufid(nr) abort
  let s:bufid = a:nr
endfun

fun! s:start_ghci() abort
  if s:bufid != -1
    echoerr "GHCI is already running or died unexpectedly"
    return s:bufid
  endif

  exec "terminal " . s:start_cmd
  let s:bufid = term_list()[0]
  return s:bufid
endfun
fun! GHCIStart() abort
  call s:start_ghci()
endfun

fun! s:stop_ghci() abort
  if s:bufid == -1
    return
  endif

  call term_sendkeys(s:bufid, ":quit\<CR>")
  let s:bufid = -1
endfun
fun! GHCIStop() abort
  call s:stop_ghci()
endfun

" Running functions

fun! s:run_cmd(cmd) abort
  call term_sendkeys(s:bufid, a:cmd . "\<CR>")
endfun

fun! s:get_last_line() abort
  let linenr = term_getsize(s:bufid)[0]
  if s:is_prompt_line(linenr) | let linenr -= 1 | endif
  return term_getline(s:bufid, linenr)
endfun
fun! LastTermLine() abort
  return s:get_last_line()
endfun

" get output of last cmd (everything between two prompts)
fun! s:get_output() abort
  let linenr = term_getsize(s:bufid)[0]
  if s:is_prompt_line(linenr) | let linenr -= 1 | endif

  let lines = []
  while !s:is_prompt_line(linenr)
    let lines = [term_getline(s:bufid, linenr)] + lines
    let linenr -= 1
  endwhile

  return join(lines, "\n")
endfun

" Utility

fun! s:is_prompt_line(linenr) abort
  return term_getline(s:bufid, a:linenr) =~ "ghci>"
endfun

fun! s:is_error_line(line) abort
  return a:line =~# "<interactive>:1:1: error: "
endfun

" matches the last :info line to get filename and line of where symbol defined
fun! s:get_defined(line, erraction) abort " :: String -> (String, Row, Column)
  if s:is_error_line(a:line)
    if a:erraction
      echoerr "Couldn't find definition: not in scope"
    endif
    return []
  endif

  let re = '\s*-- Defined at \(\w\):\([^:]\+\):\(\d\+\):\(\d\+\)'
  let matches = matchlist(a:line, re)

  if matches == []
    if a:erraction
      echoerr "Couldn't find definition: bad parse"
    endif
    return []
  endif

  return [matches[1] . ':' . matches[2], matches[3], matches[4]]
endfun
fun! GetDefined(line) abort
  return s:get_defined(a:line, v:true)
endfun


" Mappings

fun! s:go_to_definition() abort
  call s:run_cmd(":info " . expand("<cword>"))
  sleep 200m
  let info = s:get_defined(s:get_last_line(), v:false)

  if info == [] | return "gD" | endif

  let name = info[0]
  let line = info[1]
  let col  = info[2]

  return ":edit " . name . "\<CR>" . line . "gg" . col . "|"
endfun
fun! GHCIGoToDefinition() abort
  call s:go_to_definition()
endfun

fun! s:get_info_output() abort
  call s:run_cmd(":info " . expand("<cword>"))
  sleep 200m
  echo s:get_output()
endfun

fun! s:check_errors() abort
  call s:run_cmd(":reload")
  sleep 3
  call s:populate_qf()
endfun
fun! s:populate_qf() abort
  let info = s:get_output()
  let lines = split(info, "\n")
  call setqflist([], "r", {'lines':lines})
endfun

fun! s:output_open() abort
  let info = s:get_defined(s:get_last_line(), v:false)
  exec "edit " . info[0]
  exec "normal! " . info[1] . "gg" . info[2] . "|"
endfun


command! Output    :echo <SID>get_output()
command! Open      :call <SID>output_open()
command! PutInfo   :call <SID>run_cmd(":info " . expand("<cword>"))
command! Populate  :call <SID>populate_qf()
command! Info      :call <SID>get_info_output()
command! Check     :call <SID>check_errors()
command! Reload    :call <SID>run_cmd(":reload")
command! -nargs=1  GHCI :call <SID>run_cmd(<q-args>)
