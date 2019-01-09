"use later c++ standart
let g:clang_user_options = '-std=c++11'
"complete macros and constants
let g:clang_complete_macros = 1

"create a clang-complete file with gcc options for includes
silent! command! ClangCreateIncludes :make CC='~/.vim/bundle/clang_complete/bin/cc_args.py gcc' CXX='~/.vim/bundle/clang_complete/bin/cc_args.py g++' -B
