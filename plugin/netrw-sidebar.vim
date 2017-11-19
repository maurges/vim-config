" Description: A small simple plugin for nerdtree-like netrw sidebar
" see second part in after/ftplugin/netrw.vim
" as it can't be split from my configuration

"controls width of the split
let g:netrw_sidebar_width = 30


command!                         NetrwSidebar   :call netrw_sidebar#open_at('./')
command! -nargs=1 -complete=file NetrwSidebarAt :call netrw_sidebar#open_at(<args>)

command! NetrwSidebarClose  :call netrw_sidebar#close()
command! NetrwSidebarToggle :call netrw_sidebar#toggle()
