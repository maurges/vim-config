setlocal cpoptions+=M
noremap  <buffer> <silent> q :s/^\(-- \)\?/-- /<CR>
noremap  <buffer> <silent> Q :s/^\(-- \)\?//<CR>

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
nnoremap <Leader>gt :GhcModType<CR>
nnoremap <silent> <Esc> :let @/=""<CR>:set nohlsearch<CR>:GhcModTypeClear<CR>
nnoremap <Leader>gi :GhcModInfo<CR>
nnoremap <Leader>go :GhcModTypeInsert<CR>
