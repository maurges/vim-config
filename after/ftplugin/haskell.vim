"option for \ before (
setlocal cpoptions+=M

setlocal softtabstop=4
setlocal expandtab
setlocal foldmethod=indent

"compiler options
setlocal makeprg=stack\ build
setlocal errorformat=%f:%l:%v:%m

let g:ghcmod_ghc_options=['-Wall', '-fno-warn-tabs', '-fno-warn-missing-signatures']

nnoremap <buffer> <F5> :wa<CR>:make *.hs -o main<CR>
nnoremap <buffer> <F6> :w<CR>:make %<CR>
nnoremap <buffer> <F7> :w<CR>:GhcModCheck<CR>
nnoremap <buffer> <F8> :w<CR>:GhcModLint<CR>


"creates quickfix window to the right
"augroup haskell_qf
"	autocmd!
"	autocmd BufReadPost quickfix exec "normal! \<c-w>L"
"augroup end


"ghc-mod bindings
nnoremap <buffer> <Leader>gt :GhcModType<CR>
nnoremap <buffer> <Leader>gi :GhcModInfo<CR>
nnoremap <buffer> <Leader>go :GhcModTypeInsert<CR>
"call add_map#add_map("\<Esc>", ":GhcModTypeClear\<CR>", "n", "<buffer> <silent>")

setlocal omnifunc=necoghc#omnifunc
