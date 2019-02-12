inoremap <buffer> <silent> <S-CR> <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> � <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> Ý <End><CR>{<CR>}<Up><CR>

setlocal tags+=~/.vim/cpptags

inoreabbrev <buffer> main# int main(int argc, char** argv)<CR>{<CR>}<Up>

"make current file
nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>

"split source file
nnoremap <buffer> <silent> <localleader>s :vsplit %:r.cpp<CR>

setlocal omnifunc=ClangComplete

"disable clang linters
let b:ale_linters = ['clang', 'clangcheck', 'gcc']

syn keyword  cCppLetDeclaration  let
hi def link cCppLetDeclaration cppType
