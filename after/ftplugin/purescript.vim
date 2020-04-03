"option for \ before (
setlocal cpoptions+=M

"compiler options
let &l:errorformat = '%A%\s%#at %f:%l:%c - %\d%\+:%\d%\+ (%.%#)%\?,%C,%Z%\s%#%m'

"creates quickfix window to the right
augroup haskell_qf
	autocmd!
	autocmd BufReadPost quickfix exec "normal! \<c-w>L"
augroup end
