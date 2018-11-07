" Description: This plugin serves two purposes. One is to redraw the screen
" when tab was pressed in command line. The other is to go to the next match
" when tab is pressed in search prompt

" See the functions in autoload/command_tab.vim

cnoremap <expr> <tab> command_tab#tab_behavior()
cnoremap <expr> <s-tab> command_tab#shift_tab_behavior()
