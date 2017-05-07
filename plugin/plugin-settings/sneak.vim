"vim sneak settings
let g:sneak#map_netrw = 0
let g:sneak#prompt = ''
"this will get rid of the fucking highlight
augroup sneak_color
	autocmd!
	autocmd ColorScheme * hi! link Sneak Normal
augroup end
"how dared he remap my sS?!
nmap <Tab> <Plug>Sneak_s
nmap <S-Tab> <Plug>Sneak_S
xmap <Tab> <Plug>Sneak_s
xmap <S-Tab> <Plug>Sneak_S
omap <Tab> <Plug>Sneak_s
omap <S-Tab> <Plug>Sneak_S
