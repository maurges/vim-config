"dab on the haters
set nocompatible

call plug#begin('~/.vim/bundle')

" Dependencies

"requirement for some other plugins
"required by easytags
Plug 'xolox/vim-misc'
"smarter .: aware of plugins
"used by vim-surround and maybe others
Plug 'tpope/vim-repeat'
"plugin for asynchronous code execution
"required by ghc-mod
if !has("windows")
	Plug 'Shougo/vimproc.vim', {'do': 'make'}
else
	Plug 'Shougo/vimproc.vim'
endif

" General

"essentiol
Plug 'tpope/vim-surround'
"auto-closing brackets
Plug 'jiangmiao/auto-pairs'
"quick reformat
Plug 'godlygeek/tabular'
"beautiful status line
Plug 'vim-airline/vim-airline'
"beatiful themes for beatiful airline (they mostly ugly tho)
Plug 'vim-airline/vim-airline-themes'
"automatic tag creation
Plug 'xolox/vim-easytags'
"undo tree visualisation
Plug 'mbbill/undotree'
"lots of additional text objects
Plug 'wellle/targets.vim'
"stuff mainly to hot typechek haskell code
"Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
"best autocompletion evaaaar
Plug 'd86leader/vim-stupidcomplete'
"rename opened file
Plug 'danro/rename.vim'
"highlight lines changed since last commit
Plug 'airblade/vim-gitgutter'
"haskell completion engine
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
"better netrw
Plug 'd86leader/vim-netrwild'
"easier c++ writing
Plug 'd86leader/vim-cpp-helper'
"c++ completion
Plug 'd86leader/clang_complete'

" Language support plugins

Plug 'd86leader/vim-qml'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'momota/cisco.vim'

call plug#end()

filetype indent on
filetype plugin on

"i have an autocmd below that turns relativenumber off, so number is set
set relativenumber
set number
"tab stuff, mostly overwritten for filetypes
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
"can backspace over start of insertion and automatic indent
set backspace=start,indent
"can click, drag and other things with mouse in all modes
set mouse=a
"for terminal vim without airline
set ruler
"fold nicely
set foldmethod=syntax
"blink screen on errors
set visualbell
"yank can be redone with .
set cpoptions+=y
"don't save options with views
set viewoptions-=options
"searching is smart about case
set ignorecase
set smartcase
"keep two lines before cursor
set scrolloff=2
"quickfix opens next result in current buffer
set switchbuf=
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
"moving left and right with arrows can move past the line
set whichwrap=<,>,[,]
"re-read modified file
set autoread
"show trailing whitespace and non-breakable space, but don't show tab
set list
if has("windows")
	set list
	set listchars=tab:>-,trail:*
else
	set listchars=tab:\ \ ,trail:⋅,nbsp:⋅
endif
"splitting windows prioritizes right>below>rest
set splitright
set splitbelow
"commands like :find will search all subdirectories
set path+=**
"show characters typed for current command
set showcmd
"bash-like tab behavior
set wildmode=longest,list
set wildmenu
"use an unused character to start command-line completion in maps
set wildcharm=<c-o>
"use another useless character to start normal command-line completion
set wildchar=<C-Y>
"preview matches as i search
set incsearch
"when using x on a combination of symbols, delete only one of combo
set delcombine
"use cyrillic keymap for alternative layout
set keymap=russian-jcukenwin
"use latinic keymap by default
set iminsert=0
set imsearch=0
"use persistent undo
set undofile
"directories for temp files
if has("windows")
	"let it do its own thing
else
	if has("nvim")
		set undodir=~/.local/share/nvim/undo/
		set dir=~/.local/share/nvim/swap/
	else
		if !isdirectory($HOME . "/.local/share/vim/undo/")
			call mkdir($HOME . "/.local/share/vim/undo/", "p", 0755)
		endif
		if !isdirectory($HOME . "/.local/share/vim/swap/")
			call mkdir($HOME . "/.local/share/vim/swap/", "p", 0755)
		endif
		set undodir=~/.local/share/vim/undo/
		set dir=~/.local/share/vim/swap/
	endif
endif

"cursor style. The most important are cursor blinking options, others are
"default
if !has("nvim")
	set guicursor=n-v-c:block-blinkon0-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-blinkon925-blinkoff700-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
endif

"more beautiful line wrapping
if exists("&breakindent")
	set breakindent
endif

"preview changes done by :s command
if exists("&inccommand")
	set inccommand=nosplit
endif

if has("windows")
	"windows terminal uses unicode
	set encoding=utf8
	"windows uses wrong grep. It's still wrong after this option, but better
	set grepprg=grep\ -n
endif



"don't insert comment leader when creating a new line
augroup comment_formatoptions
	autocmd!
	autocmd FileType * setlocal formatoptions-=r formatoptions-=o
augroup END


"using completion-aggregator as usercomplete function
set completefunc=completion_aggreg#complete


colo blues



"unmapping shit
noremap  <Space> <nop>
noremap  K <nop>
noremap  Q <nop>
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
nnoremap X "_X
nnoremap s "_s


"it doesn't make sense by default
nnoremap Y y$
nnoremap K kJ
"this doesn't make sense in another way
inoremap <C-R> <C-R><C-P>
"this is ehh fine by default, but following is way better
xnoremap Y y`>


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
nnoremap <F10> :<C-U>tabe $MYVIMRC<CR>
nnoremap <F9>  :<C-U>tabe <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/after/ftplugin/
nnoremap <Leader><F9> :<C-U>tabe <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/plugin/
"fill a part of the path to vim files
cnoremap <F9> <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/plugin/
cnoremap <F10> <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/vimrc/


"found out I also set the filetype a lot
nnoremap <F1>   :<C-U>set filetype=
nnoremap <C-F1> :<C-U>set filetype?<CR>


"oftenly used map to make
nnoremap <F5> :<C-U>wa<CR>:make<CR>

"quickly enter and leave quickfix mode
nnoremap <silent> <F4>   :EnterQuickfix<cr>
nnoremap <silent> <C-F4> :LeaveQuickfix<cr>


"screen movement
nnoremap  = 3<C-E>
xnoremap  = 3<C-E>
nnoremap  - 3<C-Y>
xnoremap  - 3<C-Y>
nnoremap  + <C-W>p3<C-E><C-W>p
xnoremap  + <C-W>p3<C-E><C-W>p
nnoremap  _ <C-W>p3<C-Y><C-W>p
xnoremap  _ <C-W>p3<C-Y><C-W>p
inoremap <C-E> <C-X><C-E><C-X><C-E>a<BS>
inoremap <C-Y> <C-X><C-Y><C-X><C-Y>a<BS>
inoremap <A-Z> <C-O>zz
inoremap ú <C-O>zz

"other movement
"if moving more than 3 lines at once, populate the jumplist
"also move by true lines when count given, and by screen lines otherwise
nnoremap <expr> k v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'k' : 'gk'
xnoremap <expr> k v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'k' : 'gk'
nnoremap <expr> j v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'j' : 'gj'
xnoremap <expr> j v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'j' : 'gj'
"because 0 is easier to press
nnoremap  0 ^
xnoremap  0 ^
onoremap  0 ^
nnoremap  ^ 0
xnoremap  ^ 0
onoremap  ^ 0
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
"for terminal vim we use <a-]>
nnoremap Ý O<Esc>j
nnoremap � O<Esc>j


"all those helping windows
nnoremap <silent> í :<C-U>TagbarOpenAutoClose<CR>
nnoremap <silent> <A-M> :<C-U>TagbarOpenAutoClose<CR>


"helpful for search and regexps
cnoremap ;( \(\)<Left><Left>
cnoremap ;) \(\)<Left><Left>
cnoremap ;< \<\><Left><Left>
cnoremap ;> \<\><Left><Left>

"hotkeys for moving tabs
nnoremap <silent> gmt :<C-U>tabm +1<CR>
nnoremap <silent> gmT :<C-U>tabm -1<CR>
"Fucking Nice (took me a long time to think of it)
nnoremap <Space>t gT

"easily split lines
nnoremap <Space>o i<CR><Esc>

"[avaits removing] go through history
nnoremap  <Space>` <C-O>
xnoremap  <Space>` <C-O>
nnoremap  <Space>' <C-I>
xnoremap  <Space>' <C-I>

"open tag and let you choose the location
nnoremap  <Space>] g<C-]>
xnoremap  <Space>] g<C-]>

"found i use <C-W> a lot, but it's a pain to press
nmap     <Space>w <C-W>

"quickly move between windows
nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l


"some remaps to control completion
inoremap <expr> <C-C> pumvisible() ? "\<C-E>" : "\<C-C>"
inoremap <expr> <A-J> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>"
inoremap <expr> ê     pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>"
inoremap <expr> <A-K> pumvisible() ? "\<C-P>" : "\<C-X>\<C-U>\<C-P>\<C-P>"
inoremap <expr> ë     pumvisible() ? "\<C-P>" : "\<C-X>\<C-U>\<C-P>\<C-P>"


"a map to the swapwins plugin (for more info see plugin/swapwindows.vim)
nnoremap <silent> <C-W>a :<C-U>call swapwindows#with_prev(0)<CR>
"a map to copy buffer in new tab
nnoremap <C-W>t :tab split<CR>


"shortcut to quickly use macro in q
nnoremap Q @q
xnoremap Q @q


"text-object for whole file
onoremap af :<C-U>keepjumps normal! gg0vG$<CR>
xnoremap af :<C-U>keepjumps normal! gg0vG$<CR>


"more user-friendly enter ex mode
nnoremap q: q:a
nnoremap q/ q/a
nnoremap q? q?a


"close all top-level folds
nnoremap <silent> zg :%foldc<CR>


"browser-like delete word i became familiar with
inoremap <C-BS> <C-W>


"an easier map to change langmap, also it's in normal mode
inoremap <C-Space> <C-^>
nnoremap <C-Space> a<C-^><C-C>


"search for a name under cursor. Don't forget to change c-o to something when
"i change wildcharm
nnoremap gF :find <C-R>=expand("<cword>")<CR><C-O>


"reset relative number, sometimes it just isn't set
nnoremap <Leader>rn :setlocal relativenumber<CR>


"for when i have to edit other man's file
silent! command! Goodstyle :g/) {[^}]*$/execute "normal! ^f{xo{"


"delete old view files
silent! command! CleanViews :!find .vim/view/ -type f -mtime +7 -exec rm {} \;


"abbreviation for easier topleft window opening
cabbrev <expr> tl (getcmdpos() == 3 && getcmdtype() == ":") ? "topleft" : "tl"
"abbreviation for vertical split and find
cabbrev vsf vert sfind
"remake
cabbrev wmake w <bar> make

"quickly diff files in split windows
silent! command! -nargs=0 Diff   :windo setlocal diff cursorbind scrollbind
silent! command! -nargs=0 Nodiff :windo setlocal nodiff nocursorbind noscrollbind


"keep folds and other stuff when closing file
augroup autoview
	autocmd!
	autocmd BufWinLeave ?* call <SID>make_view()
	autocmd BufWinEnter ?* call <SID>load_view()
augroup END
fun! s:make_view() abort
	if @% != "" && &foldmethod != 'diff'
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
augroup END


"when leaving window, disable relativenumber
augroup relativenumber
	autocmd!
	autocmd WinEnter * call <sid>set_relativenumber()
	autocmd WinLeave * set norelativenumber
augroup END
fun! s:set_relativenumber()
	if &l:number
		set relativenumber
	endif
endfun
