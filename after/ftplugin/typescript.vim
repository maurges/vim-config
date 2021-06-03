let typescript_format = '%ATypeScript error in %f(%l\,%c):,%Z%m  TS%n'
let syntax_format = 'SyntaxError: %f: %m (%l:%c)'
let &l:errorformat = typescript_format . "," . syntax_format
set makeprg=yarn\ build:local

setlocal tags+=.tstags,./.tstags

"generate tag files
command! -nargs=? TsTags !universal-ctags --languages=TypeScript -o .tstags -R <args>

"write tags files
augroup cpp_tags
	autocmd!
	autocmd BufWritePost *.cpp silent !universal-ctags --append -o .tstags %
augroup END
