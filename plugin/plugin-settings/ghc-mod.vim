let g:ghcmod_ghc_options=['-Wall']

finish


"get a specific path from `stack path` command
fun! s:stack_path(name, path_to_yaml) abort
  let start = a:name . ": "
  let output = system("stack --stack-yaml " . a:path_to_yaml . " path")
  let lines = split(output, "\n")
  for line in lines
    if line =~# "^" . start
      return line[len(start):]
    endif
  endfor
endfun


"update the environment variable with ghc package info
fun! s:update_packages(path_to_yaml) abort
  let $GHC_PACKAGE_PATH = s:stack_path("ghc-package-path", a:path_to_yaml)
endfun

"add source paths to recordts source files
fun! s:add_sources(basedir) abort
  let dirstext = glob(a:basedir)
  let dirs = split(dirstext, "\n")
  let includes = map(dirs, '"-i" . v:val . "\\src"')
  let g:ghcmod_ghc_options += includes
endfun

fun! s:recordts_fix(path) abort
  if a:path =~? 'd:\?RecordTS\\Enterprise\?'
    call s:add_sources('source/*')
    call s:add_sources('libs/*')
    call s:update_packages("_build_debug\\x86\\stack.yaml")
    echom "done stuff"
  else
    echom a:path
  endif
endfun

augroup ghcmod_paths
  autocmd!
  autocmd DirChanged global :call <SID>recordts_fix(expand("<afile>"))
augroup end
