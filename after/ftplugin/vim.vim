setlocal tabstop=2
setlocal shiftwidth=2

if exists('b:did_indent') && b:did_indent
	inoremap <buffer> <silent> <S-CR> <ESC>^yeoend<C-R>"<ESC>O
else
	inoremap <buffer> <silent> <S-CR> <ESC>^yeoend<C-R>"<ESC>O<Tab>
endif
