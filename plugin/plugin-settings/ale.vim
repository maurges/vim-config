"disable ugly highlights
let g:ale_set_highlights = 0
"enable airline integration
let g:airline#extensions#ale#enabled = 1

"use qt include locations
let includes = ["/usr/include/qt5/QtCore", "/usr/include/qt5/QtWidgets", "/usr/include/qt5/QtGui", "/usr/include/qt5", "/usr/lib64/qt5/mkspecs/linux-g++"]

let g:ale_cpp_clang_options = '-std=c++14 -Wall'
let g:ale_cpp_gcc_options = '-std=c++14 -Wall'

for dir in includes
	let g:ale_cpp_gcc_options .= ' -I' . dir
	let g:ale_cpp_clang_options .= ' -I' . dir
endfor

