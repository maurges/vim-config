inoremap <buffer> <silent> <S-CR> <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> � <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> Ý <End><CR>{<CR>}<Up><CR>

inoreabbrev <buffer> main# int main(int argc, char** argv)<CR>{<CR>}<Up>

"split source file
nnoremap <buffer> <silent> <expr> <localleader>s ":vsplit %:r." . (expand("%:e") == "cpp" ? "{h,hpp}" : "cpp") . "\<cr>"

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
	setlocal makeprg=make
endif

setlocal grepprg=grep\ -In\ --exclude-dir={.stack-work,_build_debug,_build}\ --exclude=tags\ $*


setlocal tags+=.cpptags,./.cpptags

"generate tag files
command! -nargs=? CppTags !universal-ctags --languages=c++,c -o .cpptags -R <args>

"write tags files
augroup cpp_tags
	autocmd!
	autocmd BufWritePost *.cpp silent !univesal-ctags --append -o .cpptags %
augroup END

"TODO: dynamically determine ctags executable from ctags and universal-ctags,
"those two should be compatible
