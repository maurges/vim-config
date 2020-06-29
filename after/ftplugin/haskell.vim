"option for \ before (
setlocal cpoptions+=M

setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal foldmethod=indent

"compiler options
let &l:errorformat = '%\%%(%[a-zA-Z0-9_-]%\+ %#> %\)%\?%f:%l:%v:%m'
if filereadable("./build-remote.sh")
	setlocal makeprg=./build-remote.sh
	call hs_cabal#cabal_autocmd()
elseif filereadable("./build.sh")
	setlocal makeprg=./build.sh
else
	setlocal makeprg=stack\ build
endif

"creates quickfix window to the right
augroup haskell_qf
	autocmd!
	autocmd BufReadPost quickfix exec "normal! \<c-w>L"
augroup end

setlocal grepprg=grep\ -In\ --exclude-dir={.stack-work,_build_debug}\ --exclude=tags\ $*


"generate tag files
command! -nargs=0 HaskellTags !fast-tags -R .

"write tags files
augroup haskell_tags
	autocmd!
	autocmd BufWritePost *.hs	silent! !fast-tags %
augroup END


silent! command! -nargs=0 Format :%!stack exec -- stylish-haskell


iabbrev <buffer> lang# {-# LANGUAGE #-}<left><left><left><left>
iabbrev <buffer> lang_os# {-# LANGUAGE OverloadedStrings #-}
iabbrev <buffer> opt# {-# OPTIONS_GHC #-}<left><left><left><left>
