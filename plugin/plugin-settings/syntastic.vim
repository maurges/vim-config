"fix so that c++ uses latest standard
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++1y -fPIC'
"use correct include dirs for qt
let g:syntastic_cpp_include_dirs = ["/usr/include/qt5/QtCore", "/usr/include/qt5/QtWidgets", "/usr/include/qt5/QtGui", "/usr/include/qt5", "/usr/lib64/qt5/mkspecs/linux-g++"]
"fix so nasm uses 64 bit
let g:syntastic_nasm_nasm_args = '-f elf'

"disable red snake highlighting errors
let g:syntastic_enable_highlighting = 0

"automatically populate location list with errors
let g:syntastic_always_populate_loc_list = 1

"don't check when exiting window
let g:syntastic_check_on_wq = 0
