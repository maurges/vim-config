" Description: replace current line with text and keep all registers as they
" were

nnoremap <silent> <Space>p :call put_replace#replace_normal(v:register)<CR>
xnoremap <silent> <Space>p :call put_replace#replace_visual(v:register)<CR>
