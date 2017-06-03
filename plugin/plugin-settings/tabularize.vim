"main tabularize maps
vnoremap <silent> <Leader>t= :Tabularize assignment<CR>
nnoremap <silent> <Leader>t= :Tabularize assignment<CR>

vnoremap <silent> <Leader>t: :Tabularize /:/<CR>
nnoremap <silent> <Leader>t: :Tabularize /:/<CR>

nnoremap <silent> <Leader>t<Space> :Tabularize / /l0r0<CR>
vnoremap <silent> <Leader>t<Space> :Tabularize / /l0r0<CR>

nnoremap <silent> <leader>t, :Tabularize argument_list<CR>
vnoremap <silent> <leader>t, :Tabularize argument_list<CR>

nnoremap <silent> <Leader>t( :Tabularize /(/l1r0<CR>
vnoremap <silent> <Leader>t( :Tabularize /(/l1r0<CR>
