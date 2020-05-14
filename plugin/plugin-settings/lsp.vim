" Disable floating stuff
let g:lsp_virtual_text_enabled = 0
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_highlight_references_enabled = 0
let g:lsp_signature_help_enabled = 0


" servers

if executable('clangd')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'clangd',
		\ 'cmd': {server_info->['clangd']},
		\ 'whitelist': ['cpp', 'c'],
		\ })
endif

if executable('pyls')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
			\ 'name': 'pyls',
			\ 'cmd': {server_info->['pyls']},
			\ 'whitelist': ['python'],
			\ })
endif

if executable('rls')
	" rustup component add rls rust-analysis rust-src
	au User lsp_setup call lsp#register_server({
			\ 'name': 'rls',
			\ 'cmd': {server_info->['rls']},
			\ 'whitelist': ['rust'],
			\ })
endif


" set settings if lsp is enabled in buffer

augroup lsp_enabled_settings
	autocmd!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

fun! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	nmap <buffer> gd <plug>(lsp-definition)
endfun
