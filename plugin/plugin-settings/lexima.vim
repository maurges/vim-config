" copying as an example of what to disable
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_space_rules = 1

" disable endwise, I have my own thing
let g:lexima_enable_endwise_rules = 0

" accept completion popup with enter
let g:lexima_nvim_accept_pum_with_enter = 1

" ^h and BS now work the same
let g:lexima_ctrlh_as_backspace = 1
