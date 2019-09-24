" Description: maps for searching, moved from vimrc here
" This plugin makes it so that when you start searching, it highlights the
" text everywhere. This works for /, ?, * and #
" You can clear the highlights by simply pressing escape. Also you can search
" without highlights by using <Space>/ and <Space>?
" Another thing: it disables ignorecase for fot star and hash symbols


"disable highlighting when nothing's entered
set nohlsearch

"highlights words as i search
nnoremap / :let @/=""<CR>:set hlsearch<CR>/
nnoremap ? :let @/=""<CR>:set hlsearch<CR>?

"but also sometimes i want to search without highlights
noremap <Space>/ /
noremap <Space>? ?

"highlights the word under cursor
nnoremap <silent> g* :let @/='\C\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>

"highlights selected text
xnoremap <silent> g/ y/<C-R>"<CR>:set hlsearch<CR>

"highlights previously highlighted text
nnoremap <silent> g/ :set hlsearch<CR>

"turns off text highlighting
nnoremap <silent> <Esc> :let @/=""<CR>:set nohlsearch<CR>


"remap asterisk and hash
nnoremap <silent>  * :set hlsearch<CR>:let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>n
nnoremap <silent>  # :set hlsearch<CR>:let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n
