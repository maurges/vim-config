"tabularize maps for most used sequences

"with default patterns
vnoremap <silent> <Leader>t= :Tabularize assignment<CR>
nnoremap <silent> <Leader>t= :Tabularize assignment<CR>

nnoremap <silent> <Leader>t/ :Tabularize trailing_c_comments<CR>
vnoremap <silent> <Leader>t/ :Tabularize trailing_c_comments<CR>

nnoremap <silent> <Leader>t< :Tabularize cpp_io<CR>
vnoremap <silent> <Leader>t< :Tabularize cpp_io<CR>

nnoremap <silent> <Leader>t> :Tabularize cpp_io<CR>
vnoremap <silent> <Leader>t> :Tabularize cpp_io<CR>

nnoremap <silent> <leader>t, :Tabularize argument_list<CR>
vnoremap <silent> <leader>t, :Tabularize argument_list<CR>


"with non-margin patterns
nnoremap <silent> <Leader>t<Space> :Tabularize / /l0r0<CR>
vnoremap <silent> <Leader>t<Space> :Tabularize / /l0r0<CR>


"with basic patterns
vnoremap <silent> <Leader>t: :Tabularize /:/<CR>
nnoremap <silent> <Leader>t: :Tabularize /:/<CR>

vnoremap <silent> <Leader>t- :Tabularize /-/<CR>
nnoremap <silent> <Leader>t- :Tabularize /-/<CR>

vnoremap <silent> <Leader>t+ :Tabularize /+/<CR>
nnoremap <silent> <Leader>t+ :Tabularize /+/<CR>

vnoremap <silent> <Leader>t<bar> :Tabularize /<bar>/<CR>
nnoremap <silent> <Leader>t<bar> :Tabularize /<bar>/<CR>

vnoremap <silent> <Leader>t/ :Tabularize /\//<CR>
nnoremap <silent> <Leader>t/ :Tabularize /\//<CR>

vnoremap <silent> <Leader>t. :Tabularize /./<CR>
nnoremap <silent> <Leader>t. :Tabularize /./<CR>

vnoremap <silent> <Leader>t$ :Tabularize /$/<CR>
nnoremap <silent> <Leader>t$ :Tabularize /$/<CR>


"with only left-margin patterns
nnoremap <silent> <Leader>tb :Tabularize /(/l1r0<CR>
vnoremap <silent> <Leader>tb :Tabularize /(/l1r0<CR>

nnoremap <silent> <Leader>t[ :Tabularize /[/l1r0<CR>
vnoremap <silent> <Leader>t[ :Tabularize /[/l1r0<CR>

nnoremap <silent> <Leader>t{ :Tabularize /{/l1r0<CR>
vnoremap <silent> <Leader>t{ :Tabularize /{/l1r0<CR>
