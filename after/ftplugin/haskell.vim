"option for \ before (
setlocal cpoptions+=M

setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal foldmethod=indent

"compiler options
setlocal makeprg=.\\Build.cmd
setlocal errorformat=%f:%l:%v:%m

nnoremap <buffer> <F5> :wa<CR>:make *.hs -o main<CR>
nnoremap <buffer> <F6> :w<CR>:make %<CR>
nnoremap <buffer> <F7> :w<CR>:GhcModCheck<CR>
nnoremap <buffer> <F8> :w<CR>:GhcModLint<CR>

nnoremap <buffer> <silent> gF :call haskell#open_module(expand("<cWORD>"))<CR>


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


set grepprg=grep\ -In\ --exclude-dir={.stack-work,_build_debug}\ $*\ -r\ .
nnoremap <buffer> <expr> gd GHCIGoToDefinition()
