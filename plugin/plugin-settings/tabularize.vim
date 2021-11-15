"tabularize maps for most used sequences

"with default patterns
xnoremap <silent> <Leader>t= :Tabularize assignment<CR>
nnoremap <silent> <Leader>t= :Tabularize assignment<CR>

nnoremap <silent> <Leader>t/ :Tabularize trailing_c_comments<CR>
xnoremap <silent> <Leader>t/ :Tabularize trailing_c_comments<CR>

nnoremap <silent> <Leader>t< :Tabularize cpp_io<CR>
xnoremap <silent> <Leader>t< :Tabularize cpp_io<CR>

nnoremap <silent> <Leader>t> :Tabularize cpp_io<CR>
xnoremap <silent> <Leader>t> :Tabularize cpp_io<CR>

nnoremap <silent> <leader>t, :Tabularize argument_list<CR>
xnoremap <silent> <leader>t, :Tabularize argument_list<CR>

nnoremap <silent> <Leader>t<Space> :Tabularize spaces<CR>
xnoremap <silent> <Leader>t<Space> :Tabularize spaces<CR>


"with basic patterns
xnoremap <silent> <Leader>t: :Tabularize /:/<CR>
nnoremap <silent> <Leader>t: :Tabularize /:/<CR>

xnoremap <silent> <Leader>t- :Tabularize /-/<CR>
nnoremap <silent> <Leader>t- :Tabularize /-/<CR>

xnoremap <silent> <Leader>t+ :Tabularize /+/<CR>
nnoremap <silent> <Leader>t+ :Tabularize /+/<CR>

xnoremap <silent> <Leader>t<bar> :Tabularize /<bar>/<CR>
nnoremap <silent> <Leader>t<bar> :Tabularize /<bar>/<CR>

xnoremap <silent> <Leader>t/ :Tabularize /\//<CR>
nnoremap <silent> <Leader>t/ :Tabularize /\//<CR>

xnoremap <silent> <Leader>t. :Tabularize /./<CR>
nnoremap <silent> <Leader>t. :Tabularize /./<CR>

xnoremap <silent> <Leader>t$ :Tabularize /$/<CR>
nnoremap <silent> <Leader>t$ :Tabularize /$/<CR>


"with only left-margin patterns
nnoremap <silent> <Leader>tb :Tabularize /(/l1r0<CR>
xnoremap <silent> <Leader>tb :Tabularize /(/l1r0<CR>

nnoremap <silent> <Leader>t[ :Tabularize /[/l1r0<CR>
xnoremap <silent> <Leader>t[ :Tabularize /[/l1r0<CR>

nnoremap <silent> <Leader>t{ :Tabularize /{/l1r0<CR>
xnoremap <silent> <Leader>t{ :Tabularize /{/l1r0<CR>
