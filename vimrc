set nocompatible

call plug#begin('~/.vim/bundle')

"essentiol
Plug 'tpope/vim-surround'
"requirement for some other plugins
Plug 'xolox/vim-misc'
"auto-closing brackets
Plug 'Raimondi/delimitMate'
"regexes in search
Plug 'haya14busa/incsearch.vim'
"file tree
"Plug 'scrooloose/nerdtree'
"rust colors, syntax, ftplugin
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"quick reformat
Plug 'godlygeek/tabular'
"source code browsing bar
Plug 'majutsushi/tagbar'
"beautiful status line
Plug 'vim-airline/vim-airline'
"beatiful themes for beatiful airline (they mostly ugly tho)
Plug 'vim-airline/vim-airline-themes'
"automatic tag creation
Plug 'xolox/vim-easytags'
"indent text-object
Plug 'michaeljsmith/vim-indent-object'
"smarter .
Plug 'tpope/vim-repeat'
"fast search by two characters
Plug 'justinmk/vim-sneak'
"change date with only a few keystrokes!
Plug 'tpope/vim-speeddating'
"undo tree visualisation
Plug 'mbbill/undotree'
"show tab layers
"Plug 'nathanaelkane/vim-indent-guides'
"special symbols for haskell
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
"lots of additional text objects
Plug 'wellle/targets.vim'
"plugin for asynchronous code execution (for other plugins)
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"stuff mainly to hot typechek haskell code
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
"best autocompletion evaaaar
Plug 'd86leader/vim-stupidcomplete'
"hacker scratchpad plugin
Plug 'metakirby5/codi.vim'
"rename opened file
Plug 'danro/rename.vim'
"exchange two regions
Plug 'tommcdo/vim-exchange'
"haskell syntax highlight and indentation
Plug 'neovimhaskell/haskell-vim'

call plug#end()

filetype indent on
filetype plugin on

set number
set tabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set mouse=a
set ruler
set foldmethod=syntax
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
"don't redraw screen when executing untyped commands
set lazyredraw
"there's a fishy thing going on with selections; disable it
set guioptions-=a
set clipboard-=autoselect
"when beginning of line was aligned with spaces, copy them
set copyindent
"this preview is shite, especially with my stupidcomplete
set completeopt-=preview
"when starting completion, show options and fill the longest common
set completeopt+=longest
"moving left and right can move past the line
set whichwrap=b,s,<,>,[,]
"re-read modified file
set autoread
"showing non-printable characters: i don't need it right now
set nolist
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
"splitting windows prioritizes right>below>rest
set splitright
set splitbelow

"cursor style. The most important are cursor blinking options, others are
"default
if !has("nvim")
	set guicursor=n-v-c:block-blinkon0-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-blinkon925-blinkoff700-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
endif

"beautiful line wrapping
if exists("&breakindent")
	set breakindent
endif

"don't insert comment leader when creating a new line
augroup comment_formatoptions
	autocmd!
	autocmd FileType * setlocal formatoptions-=r formatoptions-=o
augroup end


"open the largest possible window when is gvim
if has("gui_running")
	set lines=9999 columns=9999
endif


"using stupidcomplete as usercomplete function
set completefunc=Stupidcomplete


"a new colorscheme in town
"colo vorange
"if !has("gui_running")
	colo blues
"endif



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
"hate that small deletes overwrite unnamed
nnoremap x "_x


"it doesn't make sense by default
nnoremap Y y$
nnoremap K kJ
"this doesn\t make sense on another level
inoremap <C-R> <C-R><C-P>

"i'm too used to q to comment, but macros are nice
noremap <BS> q


"faster navigation in insert mode
inoremap <A-H> <Left>
inoremap è <Left>
inoremap <A-L> <Right>
inoremap ì <Right>
imap     <A-O> <Esc>o
imap     ï <Esc>o
imap     <A-A> <End>
imap     á <End>
"also this is a very good map, useful in normal mode too
nmap     <A-A> A
nmap     á A


"yeah i edit vimrc a lot
nnoremap <F10> :<C-U>tabe ~/.vim/vimrc<CR>
nnoremap <F9>  :<C-U>tabe ~/.vim/after/ftplugin/
nnoremap <Leader><F9> :<C-U>tabe ~/.vim/plugin/
"sources from selected ftplugin
nnoremap <C-F9>   :<C-U>source ~/.vim/after/ftplugin/
nnoremap <C-S-F9> :<C-U>source ~/.vim/after/ftplugin/
"sources from vimrc and required ftplugin if it exists
nnoremap <C-F10>   :<C-U>source ~/.vim/vimrc<CR>:if filereadable("~/.vim/after/ftplugin/".&filetype.".vim") <Bar> :exec "source ~/.vim/after/ftplugin/".&filetype.".vim" <Bar> :endif<CR>
nnoremap <C-S-F10> :<C-U>source ~/.vim/vimrc<CR>:if filereadable("~/.vim/after/ftplugin/".&filetype.".vim") <Bar> :exec "source ~/.vim/after/ftplugin/".&filetype.".vim" <Bar> :endi<CR>


"found out I also set the filetype a lot
nnoremap <F1>   :<C-U>set filetype=
nnoremap <C-F1> :<C-U>set filetype?<CR>


"while we're at it, some quickfix maps
nnoremap <F5> :<C-U>wa<CR>:make<CR>

"some quickfix window maps
"this one remembers current tab, opens/closes quickfix everywhere and returns to it
nnoremap <silent> <F4>   :<C-U>let _ctabpage=tabpagenr()<CR>:tabdo copen<CR>:execute "normal! " . _ctabpage . "gt"<CR>
nnoremap <silent> <C-F4> :<C-U>let _ctabpage=tabpagenr()<CR>:tabdo cclose<CR>:execute "normal! " . _ctabpage . "gt"<CR>
"fast moving between errors
nnoremap <silent> <C-N> :<C-U>cn<CR>
nnoremap <silent> <C-P> :<C-U>cp<CR>


"delimitmate maps for expanding space and enter
silent! imap <unique> <buffer> <CR> <Plug>delimitMateCR
silent! imap <unique> <buffer> <Space> <Plug>delimitMateSpace


"screen movement
noremap  = 3<C-E>
noremap  - 3<C-Y>
noremap  + <C-W>p3<C-E><C-W>w
noremap  _ <C-W>p3<C-Y><C-W>w
inoremap <C-E> <C-X><C-E><C-X><C-E>a<BS>
inoremap <C-Y> <C-X><C-Y><C-X><C-Y>a<BS>
inoremap <A-Z> <C-O>zz
inoremap ú <C-O>zz

"other movement
"if moving more than 3 lines at once, populate the jumplist
"also move by true lines when count given, and by screen lines otherwise
noremap <expr> k v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'k' : 'gk'
noremap <expr> j v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'j' : 'gj'
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
xnoremap <Space>e $
onoremap <Space>e $
"easily add new lines
nnoremap <CR> o<Esc>k
nnoremap <S-CR> O<Esc>j
"a kostyl for terminal vim: <A-]> is what i would never press
nnoremap Ý O<Esc>j
nnoremap � O<Esc>j
"easily split lines
nnoremap <C-O> i<CR><Esc>


"all those helping windows
nnoremap <silent> æ :<C-U>NetrwSidebarToggle<CR>
nnoremap <silent> <A-F> :<C-U>NetrwSidebarToggle<CR>
nnoremap <silent> í :<C-U>TagbarOpenAutoClose<CR>
nnoremap <silent> <A-M> :<C-U>TagbarOpenAutoClose<CR>
nnoremap <silent> õ :<C-U>UndotreeToggle<CR>
nnoremap <silent> <A-U> :<C-U>UndotreeToggle<CR>


"helpful for search and regexps
cnoremap ;( \(\)<Left><Left>
cnoremap ;) \(\)<Left><Left>
cnoremap ;< \<\><Left><Left>
cnoremap ;> \<\><Left><Left>

"hotkeys for moving tabs
nnoremap <silent> gmt :<C-U>tabm +1<CR>
nnoremap <silent> gmT :<C-U>tabm -1<CR>


"i want space to be a g-like modifier for useful stuff
nnoremap <silent> <Space>p Vp
nnoremap <silent> <Space>P kVp
xnoremap <silent> <Space>p p
noremap  <Space>` <C-O>
noremap  <Space>' <C-I>
map      <Space>+ <C-A>
map      <Space>- <C-X>
"took me a long time to think of it
nnoremap <Space>t gT

noremap  <Space>] g<C-]>
"if i knew more i maybe would like to delete it
nnoremap <Space>[ <C-T>

"found i use <C-W> a lot, but it's a pain to press
nmap     <Space>w <C-W>


"hotkey to quickly replace word under cursor
nnoremap <F2> yiw:tabdo %s/<C-R>"/
"and quickly replace all occurences of selected text
xnoremap <F2> y:tabdo %s/<C-R>"/


"some remaps to control completion
inoremap <expr> <C-C> pumvisible() ? "\<C-E>" : "\<C-C>"
inoremap <expr> <CR>  pumvisible() ? "\<C-Y>" : "\<CR>"
inoremap <expr> <A-J> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>"
inoremap <expr> ê     pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>"
inoremap <expr> <A-K> pumvisible() ? "\<C-P>" : "\<C-X>\<C-U>\<C-P>\<C-P>"
inoremap <expr> ë     pumvisible() ? "\<C-P>" : "\<C-X>\<C-U>\<C-P>\<C-P>"


"a map to the swapwins plugin (for more info see plugin/swapwindows.vim)
nnoremap <silent> <C-W>a :<C-U>call Swap_window_with_prev(0)<CR>


"follow tag under cursor in new tab
nnoremap <Space>g] yiw:tab tjump <C-R>"<CR>
xnoremap <Space>g] y:tab tjump <C-R>"<CR>


"quickly paste register contents with ' (as i only use ` for marks)
nnoremap <expr> ' '"' . nr2char(getchar()) . 'P'
xnoremap <expr> ' '"' . nr2char(getchar()) . 'P'


"fast macro definition/usage
nnoremap <BS><BS> qq
nnoremap <BS><S-BS> qQ
nnoremap <S-BS> @q


"quickly move between windows (i never move between paragraphs)
nnoremap { <C-W>W
nnoremap } <C-W>w


"text-object for whole file
onoremap af :<C-U>keepjumps normal! ggvG<CR>
xnoremap af :<C-U>keepjumps normal! ggvG<CR>


"toggle visibility of some characters
nnoremap <silent> <Leader><Leader>l :let &list = !&list<CR>


"for when i have to edit other man's file
silent! command! Goodstyle :g/) {[^}]*$/execute "normal! ^f{xo{"
silent! command! Implodetab2 :%s/  /	/g
silent! command! Implodetab4 :%s/    /	/g


"Close tab if only netrwsidebar is left
augroup nerdtreecloser
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:is_netrw_sidebar")) | q | endif
augroup end


"keep folds and other stuff when closing file
augroup autoview
	autocmd!
	autocmd BufWinLeave ?* call s:make_view()
	autocmd BufWinEnter ?* call s:load_view()
augroup end
fun! s:make_view() abort
	if @% != ""
		mkview!
	endif
endfun
fun! s:load_view() abort
	if @% != ""
		silent! loadview
	endif
endfun


"the following code removes omnicompletion window after the completion is finished
augroup omniclose
	autocmd!
	autocmd CompleteDone * pclose
augroup end



" Some setting which can't be set in plugin-settings for some reason

"this will get rid of the fucking sneak highlight
augroup sneak_color
	autocmd!
	autocmd ColorScheme * hi! link Sneak Normal
augroup end


"delimitmate settings
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
