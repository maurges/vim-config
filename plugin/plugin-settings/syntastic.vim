"fix so that c++ uses latest standard
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++1y'
"fix so nasm uses 64 bit
let g:syntastic_nasm_nasm_args = '-f elf64'

"automatically populate location list with errors
let syntastic_always_populate_loc_list = 1

"don't check when exiting window
let syntastic_check_on_wq = 0
