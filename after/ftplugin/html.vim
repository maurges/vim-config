if exists('b:did_indent') && b:did_indent
	inoremap <buffer> <silent> <S-CR> <Esc>y%%p%a/<Esc>f dt>%i<CR><Esc>O
else
	inoremap <buffer> <silent> <S-CR> <Esc>y%%p%a/<Esc>f dt>%i<CR><Esc>O<Tab>
endif
setlocal tabstop=2
setlocal shiftwidth=2
