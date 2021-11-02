if !exists("g:lsp_enable_intrusiveness")
	let g:lsp_enable_intrusiveness = v:true
endif

" preview window doesn't steal focus
let g:lsp_preview_keep_focus = 1
" disable highlighting symbol under cursor
let g:lsp_document_highlight_enabled = 0
" disable semantic highlighting (although..)
let g:lsp_semantic_enabled = 0
" don't use ignorecase, match strictly
let g:lsp_ignorecase = v:false
" write lsp logs
let g:lsp_log_file = expand("$HOME") . "/.local/share/vim-lsp.log"

" enable diagnostics
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_prefix = "   ‣ "
let g:lsp_diagnostics_signs_error = {"text": '✗'}
let g:lsp_diagnostics_signs_warning = {"text": '‼'}
let g:lsp_diagnostics_signs_information = {"text": '⁈'}
let g:lsp_diagnostics_signs_hint = {"text": '⁇'}
let g:lsp_document_code_action_signs_hint = {"text": '💡'}

if !g:lsp_enable_intrusiveness
	let g:lsp_diagnostics_echo_cursor = 0
	let g:lsp_diagnostics_float_cursor = 0
	let g:lsp_diagnostics_highlights_enabled = 0
	let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
	let g:lsp_diagnostics_signs_enabled = 0
	let g:lsp_diagnostics_virtual_text_enabled = 0
	" disable code action signs as well
	let g:lsp_document_code_action_signs_enabled = 0
	" don't know what it is
	let g:lsp_signature_help_enabled = 0
	" disbale showing changes made in a workspace edit
	let g:lsp_show_workspace_edits = 0
endif


" mappings
nmap <leader>h <plug>(lsp-hover)
nmap <leader>a <plug>(lsp-code-action)
cabbrev <expr> diag (getcmdpos() == 5 && getcmdtype() == ":") ? "LspDocumentDiagnostics" : "diag"

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

if executable('ocamllsp')
	" opam install ocaml-lsp-server
	au User lsp_setup call lsp#register_server({
			\ 'name': 'ocamllsp',
			\ 'cmd': {server_info->['ocamllsp']},
			\ 'whitelist': ['ocaml'],
			\ })
endif

if executable('haskell-language-server')
	" nix-env -iA nixpkgs.haskell-language-server
	au User lsp_setup call lsp#register_server({
			\ 'name': 'haskell-language-server',
			\ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
			\ 'whitelist': ['haskell', 'lhaskell'],
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
