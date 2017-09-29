setlocal commentstring=;%s
setlocal tabstop=10
setlocal shiftwidth=10

setlocal foldmethod=marker

inoremap <buffer> <silent> <S-CR> <ESC>0lyeo%end<ESC>pO<Tab>

nnoremap <buffer> <F6> :w<CR>:make %:r.o<CR>
