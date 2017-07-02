if exists('b:did_indent') && b:did_indent
	inoremap <buffer> <silent> <S-CR> <End><CR>end<Up><End><CR>
	inoremap <buffer> <silent> Ý <End><CR>end<Up><End><CR>
	inoremap <buffer> <silent> � <End><CR>end<Up><End><CR>
else
	inoremap <buffer> <silent> <S-CR> <End><CR>end<Up><End><CR><Tab>
	inoremap <buffer> <silent> Ý <End><CR>end<Up><End><CR><Tab>
	inoremap <buffer> <silent> � <End><CR>end<Up><End><CR><Tab>
endif

set omnifunc=rubycomplete#Complete

iabbrev main: if __FILE__ == $0<CR>end<Up><End>
