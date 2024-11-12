if executable("deno")
	let &l:errorformat = '%Eerror: TS%n [ERROR]: %m,%ETS%n [ERROR]: %m,%Z    at file://%f:%l:%c,%C%.%#'
	setlocal makeprg=env\ NO_COLOR=true\ deno\ check
endif
