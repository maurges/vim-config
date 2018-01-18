inoremap <buffer> <silent> <S-CR> <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> � <End><CR>{<CR>}<Up><CR>
inoremap <buffer> <silent> Ý <End><CR>{<CR>}<Up><CR>

set tags+=~/.vim/cpptags

inoreabbrev <buffer> main# int main(int argc, char** argv)<CR>{<CR>}<Up>

"make current file
nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>
