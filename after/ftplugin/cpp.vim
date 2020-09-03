inoremap <buffer> <silent> <S-CR> <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> � <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> Ý <End><CR>{<CR>}<Up><CR>

setlocal tags+=~/.vim/cpptags

inoreabbrev <buffer> main# int main(int argc, char** argv)<CR>{<CR>}<Up>

"make current file
nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>

"split source file
nnoremap <buffer> <silent> <localleader>s :vsplit %:r.cpp<CR>

syn keyword  cCppLetDeclaration  let
hi def link cCppLetDeclaration cppType


"compiler options
if filereadable("./build-remote.json")
	setlocal makeprg=build-remote.py
elseif filereadable("./build-remote.sh")
	setlocal makeprg=./build-remote.sh
elseif filereadable("./build.sh")
	setlocal makeprg=./build.sh
else
	setlocal makeprg=stack\ build
endif

setlocal grepprg=grep\ -In\ --exclude-dir={.stack-work,_build_debug,_build}\ --exclude=tags\ $*
