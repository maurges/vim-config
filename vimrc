set nocompatible

execute pathogen#infect()

filetype plugin on

set number
set tabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set mouse=a
set ruler
"blink screen on errors
set visualbell
"bash-like tab behavior
set wildmode=list:longest
"yank can be redone with .
set cpoptions+=y
"don't save options with views
set viewoptions-=options
"good shit
set relativenumber
"searching is smart about case
set ignorecase
set smartcase
"keep two lines before cursor
set scrolloff=2
"quickfix windows searches for open tab, splits if not found
set switchbuf=usetab,split
"include keyword should look like this:
set include=^\s*\(#\s*include\|import\)

"set matchpairs+=<:>
"moving left and right can move past the line
set whichwrap=b,s,<,>,[,]
"re-read modified file
set autoread
"showing non-printable characters: i don't need it right now
"set list
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set foldmethod=syntax
"splitting windows prioritizes right>below>rest
set splitright
set splitbelow

"prettier nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeMouseMode = 3
let NERDTreeQuitOnOpen = 1


"for tagbar to show it's contents chronologically
let g:tagbar_sort = 0


"delimitmate settings
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1


"for easytags to keep separate tag files
set tags=./.tags,./.TAGS
let g:easytags_dynamic_files = 2
"also asynchronous updates
let g:easytags_async=1


"airline settings
let g:airline_powerline_fonts=1
set laststatus=2
"disable ugly error sections
let g:airline_section_warning = ''
let g:airline_section_error = ''

let g:airline_theme='raven'

"disable airline for console
if !has("gui_running")
	let g:loaded_airline = 1
endif


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


"a new colorscheme in town
colo vorange
if !has("gui_running")
	colo blues
endif



"unmapping shit
noremap  <Space> <nop>
noremap  K <nop>
noremap  Q <nop>
noremap  q <nop>
noremap  R <nop>
noremap  S <nop>
"don't want that annoying help window
nnoremap <F1> <NOP>
nnoremap <S-F1> <NOP>
"this thing exists in insert mode!
inoremap <F1> <NOP>
inoremap <S-F1> <NOP>
"visual too just in case
vnoremap <F1> <NOP>
vnoremap <S-F1> <NOP>


"it doesn't make sense by default
nnoremap Y y$
nnoremap K kJ
"this doesn\t make sense on another level
inoremap <C-R> <C-R><C-P>

"i'm too used to q to comment, but macros are nice
noremap <BS> q

"better shortcuts for completion
inoremap <M-J> <C-N>
inoremap ê <C-N>
inoremap <M-K> <C-P>
inoremap ë <C-P>


"faster navigation in insert mode
inoremap <M-H> <Left>
inoremap è <Left>
inoremap <M-L> <Right>
inoremap ì <Right>
imap     <M-O> <Esc>o
imap     ï <Esc>o
imap     <M-A> <End>
imap     á <End>
"also this is a very good map, useful in normal mode too
nmap     <M-A> A
nmap     á A


"yeah i edit vimrc a lot
nnoremap <F10> :tabe ~/.vim/vimrc<CR>
nnoremap <C-F10> :source ~/.vim/vimrc<CR>
nnoremap <C-S-F10> :source ~/.vim/vimrc<CR>
nnoremap <F9> :tabe ~/.vim/after/ftplugin/
nnoremap <C-F9> :source ~/.vim/after/ftplugin/
nnoremap <C-S-F9> :source ~/.vim/after/ftplugin/


"found out I also set the filetype a lot
nnoremap <F1> :set filetype=
nnoremap <C-F1> :set filetype?<CR>


"while we're at it, some quickfix maps
nnoremap <F5> :wa<CR>:make<CR>

"some quickfix window maps
"this one remembers current tab, opens/closes quickfix everywhere and returns to it
nnoremap <silent> <F4> :let _ctabpage=tabpagenr()<CR>:tabdo copen<CR>:execute "normal! " . _ctabpage . "gt"<CR>
nnoremap <silent> <C-F4> :let _ctabpage=tabpagenr()<CR>:tabdo cclose<CR>:execute "normal! " . _ctabpage . "gt"<CR>
"fast moving between errors
nnoremap <silent> <C-N> :cn<CR>
nnoremap <silent> <C-P> :cp<CR>


"highlights words as i search
nmap / :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-forward)
nmap ? :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-backward)
nnoremap <silent> * :set hlsearch<CR>*
nnoremap <silent> # :set hlsearch<CR>#
"but also sometimes i want to search without highlights
noremap <Space>/ /
noremap <Space>? ?
"highlights the word under cursor
nnoremap <silent> g* yiw:let @/=@"<CR>:set hlsearch<CR>
vnoremap <silent> g* <C-C>yiw:let @/=@"<CR>:set hlsearch<CR>gv
"highlights selected text
vnoremap <silent> g/ y/<C-R>"<CR>:set hlsearch<CR>
"highlights previously highlighted text
nnoremap <silent> g/ :set hlsearch<CR>
"turns off text highlighting
nnoremap <silent> <Esc> :let @/=""<CR>:set nohlsearch<CR>


"delimitmate maps for expanding space and enter
imap <unique> <buffer> <CR> <Plug>delimitMateCR
imap <unique> <buffer> <Space> <Plug>delimitMateSpace


"screen movement
noremap  = 3<C-E>
noremap  - 3<C-Y>
inoremap <C-E> <C-X><C-E><C-X><C-E>a<BS>
inoremap <C-Y> <C-X><C-Y><C-X><C-Y>a<BS>
inoremap <A-Z> <C-O>zz
inoremap ú <C-O>zz

"other movement
noremap  k gk
noremap  j gj
"because 0 is easier to press
noremap  0 ^
onoremap 0 ^
noremap  ^ 0
onoremap ^ 0
"also home should go to the first non-blank character, not just first
noremap  <Home> ^
inoremap <Home> <C-O>^
inoremap <S-Home> <Home>
"because $ is hard to press
nnoremap <Space>e $
vnoremap <Space>e $
onoremap <Space>e $
"easily add new lines
nnoremap <CR> o<Esc>k
nnoremap <S-CR> O<Esc>j
"easily split lines
nnoremap <C-O> i<CR><Esc>


"all those helping windows
nnoremap <silent> æ <Esc>:NERDTreeToggle<CR>
nnoremap <silent> <A-F> <Esc>:NERDTreeToggle<CR>
nnoremap <silent> í :TagbarOpenAutoClose<CR>
nnoremap <silent> <A-M> :TagbarOpenAutoClose<CR>


"helpful for search and regexps
cnoremap ;( \(\)<Left><Left>
cnoremap ;) \(\)<Left><Left>
cnoremap ;< \<\><Left><Left>
cnoremap ;> \<\><Left><Left>

"hotkeys for moving tabs
nnoremap <silent> gmt :tabm +1<CR>
nnoremap <silent> gmT :tabm -1<CR>


"i want space to be a g-like modifier for useful stuff
nnoremap <silent> <Space>p Vp
nnoremap <silent> <Space>P kVp
vnoremap <silent> <Space>p p
noremap  <Space>` <C-O>
noremap  <Space>' <C-I>
map      <Space>+ <C-A>
map      <Space>- <C-X>
"took me a lot to think of it
nnoremap <Space>t gT

noremap  <Space>] g<C-]>
"if i knew more i maybe would like to delete it
nnoremap <Space>[ <C-T>

"better surround-vim maps with spaaace
nmap     <Space>s ys
vmap     <Space>s S
nmap     <Space>s<Space> ys$

"found i use <C-W> a lot, but it's a pain to press
nnoremap <Space>w <C-W>


"hotkey to quickly replace word under cursor
nnoremap <F2> yiw:tabdo %s/<C-R>"/
"and quickly replace all occurences of selected text
vnoremap <F2> y:tabdo %s/<C-R>"/




"for when i have to edit other man's file
command! Goodstyle :g/) {[^}]*$/execute "normal! ^f{xo{"
command! Implodetab2 :%s/  /	/g
command! Implodetab4 :%s/    /	/g


"maps for comments for files
noremap <buffer> <silent> q :s/^#\?/#/<CR>
noremap <buffer> <silent> Q :s/^#\?//<CR>


"Close tab if only nerdtree is left
augroup nerdtreecloser
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end


"keep folds and other stuff when closing file
augroup autoview
	autocmd!
	autocmd BufWritePre ?* if @% != "" | mkview! | endif
	autocmd BufWinEnter ?* if @% != "" | silent! loadview | endif
augroup end


"the following code removes omnicompletion window after the completion is finished
augroup omniclose
	autocmd!
	autocmd CompleteDone * pclose
augroup end


"an omnicompletion fix: inserts a closing bracket when text has opening one
"inoremap <C-x><C-o> <C-r>=<SID>close_paren()<CR><C-x><C-o>
"function! s:close_paren() abort
"    augroup close_paren
"        autocmd!
"        autocmd CompleteDone <buffer> if v:completed_item.word && v:completed_item.word =~# '($'
"                                   \ |     call feedkeys(")\<Left>", 'in')
"                                   \ | endif
"                                   \ | autocmd! close_paren
"                                   \ | augroup! close_paren
"    augroup END
"    return ''
"endfunction
