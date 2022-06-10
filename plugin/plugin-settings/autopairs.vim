"disable all mappings
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsMapCR = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMoveCharacter = ''
let g:AutoPairsMultilineClose = 0

"changed to use autopairs plugin closing behavior after cr
imap <silent> <expr> <CR>  pumvisible() ? "\<C-Y>" : "\<CR>\<Plug>AutoPairsReturn"
