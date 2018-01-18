setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent

inoremap <buffer> <silent> <S-CR> <ESC>^yeoend<C-R>"<ESC>O
inoremap <buffer> <silent> Ý <ESC>^yeoend<C-R>"<ESC>O
inoremap <buffer> <silent> � <ESC>^yeoend<C-R>"<ESC>O



"map to quickly toggle options in vimrc
nnoremap <expr> <silent> ! <SID>toggle_line_option()
fun! s:toggle_line_option()
	let l = getline(line('.'))
	let apply = "0Y:\<C-R>\"\<BS>\<CR>"
	if l =~ '\s*set [^+-]*= "'
		return "0f=lxx" . apply
	elseif l =~ '\s*set [^+-]*='
		return "0f=a \"\<Esc>" . apply
	elseif l =~ '\s*set no'
		return "0ftllxx" . apply
	elseif l =~ '\s*set [^=]*$'
		return "0ftlano\<Esc>" . apply
	elseif l =~ '\s*autocmd'
		return "0i\"\<Esc>"
	elseif l =~ '"\s*autocmd'
		return "0x"
	else
		return ""
	endif
endfun
