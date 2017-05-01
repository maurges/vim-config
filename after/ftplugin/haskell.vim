setlocal cpoptions+=M

setlocal makeprg=ghc\ --make\ -Wall\ -fno-warn-tabs
let g:ghcmod_ghc_options=['-Wall', '-fno-warn-tabs']

nnoremap <F5> :wa<CR>:make *.hs -o main<CR>
nnoremap <buffer> <F6> :w<CR>:make %<CR>
nnoremap <buffer> <F7> :w<CR>:GhcModCheck<CR>
nnoremap <buffer> <F8> :w<CR>:GhcModLint<CR>


"creates quickfix window to the right
augroup haskell_qf
	autocmd!
	autocmd BufReadPost quickfix exec "normal! \<c-w>L"
augroup end


"ghc-mod bindings
nnoremap <buffer> <Leader>gt :GhcModType<CR>
nnoremap <buffer> <silent> <Esc> :let @/=""<CR>:set nohlsearch<CR>:GhcModTypeClear<CR>
nnoremap <buffer> <Leader>gi :GhcModInfo<CR>
nnoremap <buffer> <Leader>go :GhcModTypeInsert<CR>
