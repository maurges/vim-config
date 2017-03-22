inoremap <buffer> <silent> <S-CR> <End><CR>{<CR>}<Up><CR>
noremap  <buffer> <silent> q :s/^\(\/\/\)\?/\/\//<CR>
noremap  <buffer> <silent> Q :s/^\(\/\/\)\?//<CR>
iabbrev  <buffer> and &&
iabbrev  <buffer> or \|\|

set tags+=~/.vim/cpptags

inoreabbrev <buffer> main# int main(int argc, char** argv)<CR>{<CR>}<Up>

"make current file
nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>
