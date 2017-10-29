inoremap <buffer> <silent> <S-CR> <End><CR>end<Up><End><CR>
inoremap <buffer> <silent> Ý <End><CR>end<Up><End><CR>
inoremap <buffer> <silent> � <End><CR>end<Up><End><CR>

set omnifunc=rubycomplete#Complete

iabbrev main: if __FILE__ == $0<CR>end<Up><End>
