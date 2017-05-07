" Description: maps for searching, moved from vimrc here
" This plugin makes it so that when you start searching, it highlights the
" text everywhere. This works for /, ?, * and #
" You can clear the highlights by simply pressing escape. Also you can search
" without highlights by using <Space>/ and <Space>?


"highlights words as i search
nmap / :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-forward)
nmap ? :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-backward)
nnoremap <silent> * :set hlsearch<CR>*
nnoremap <silent> # :set hlsearch<CR>#

"but also sometimes i want to search without highlights
noremap <Space>/ /
noremap <Space>? ?

"highlights the word under cursor
nnoremap <silent> g* yiw:let @/=@"<CR>:set hlsearch<CR>
vnoremap <silent> g* <C-C>yiw:let @/=@"<CR>:set hlsearch<CR>gv

"highlights selected text
vnoremap <silent> g/ y/<C-R>"<CR>:set hlsearch<CR>

"highlights previously highlighted text
nnoremap <silent> g/ :set hlsearch<CR>

"turns off text highlighting
nnoremap <silent> <Esc> :let @/=""<CR>:set nohlsearch<CR>
