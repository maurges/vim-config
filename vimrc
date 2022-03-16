"dab on the haters
set nocompatible

call plug#begin(fnamemodify(expand("$MYVIMRC"), ":h") .. "/bundle")

" Dependencies

"smarter .: aware of plugins
"used by vim-surround and maybe others
Plug 'tpope/vim-repeat'
"used by vim-lsp
"Plug 'prabirshrestha/async.vim'

" General

"essentiol
Plug 'tpope/vim-surround'
"auto-closing brackets
Plug 'jiangmiao/auto-pairs'
"quick reformat
Plug 'godlygeek/tabular'
"undo tree visualisation
Plug 'mbbill/undotree'
"lots of additional text objects
Plug 'wellle/targets.vim'
"best autocompletion evaaaar
Plug 'd86leader/vim-stupidcomplete'
"rename opened file
Plug 'danro/rename.vim'
"highlight lines changed since last commit
Plug 'airblade/vim-gitgutter'
"better netrw
Plug 'd86leader/vim-netrwild'
"easier c++ writing
Plug 'd86leader/vim-cpp-helper'
"detect correct tabstop
Plug 'd86leader/vim-sleuth'
"indent movements
Plug 'jeetsukumaran/vim-indentwise'
"marker folds in foldmethod=syntax (doesn't work for indent)
Plug 'Jorengarenar/vim-syntaxMarkerFold'
"hacker scratchpad
Plug 'metakirby5/codi.vim'
"use nvim in firefox
if has("nvim-0.4.0")
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif
"command runner like postman
if has("nvim-0.4.0")
	Plug 'd86leader/curlman'
endif

" Language support plugins

if has("nvim-0.5.0")
	Plug 'neovim/nvim-lspconfig'
endif

" some are my forks while the authors neglect their repos
"Plug 'prabirshrestha/vim-lsp'
Plug 'd86leader/vim-qml'
Plug 'd86leader/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'momota/cisco.vim'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'purescript-contrib/purescript-vim'
Plug 'vmchale/dhall-vim'
Plug 'd86leader/idris2-vim'
Plug 'LnL7/vim-nix'

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
set backspace=start,indent,eol
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
set viewoptions=folds,cursor
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
if has("win32")
	call listchars#set()
else
	call listchars#unset()
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
if has("win32")
	let prefix = fnamemodify(expand("$MYVIMRC"), ":h") . "/tempfiles/"
	if !isdirectory(prefix . "undo")
		call mkdir(prefix . "undo", "p", 0755)
	endif
	if !isdirectory(prefix . "swap")
		call mkdir(prefix . "swap", "p", 0755)
	endif
	exec ":set undodir=" . prefix . "undo"
	exec ":set dir=" . prefix . "swap"
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

if has("win32")
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


set termguicolors
colo blues



"unmapping shit
noremap  <Space> <nop>
noremap  K <nop>
noremap  Q <nop>
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
"also unify S action with X and s
nnoremap S "_Xi

"it doesn't make sense by default
nnoremap Y y$
nnoremap K kJ
"this doesn't make sense in another way
inoremap <C-R> <C-R><C-P>
"this is ehh fine by default, but following is way better
xnoremap Y y`>


"yeah i edit vimrc a lot
nnoremap <F10> :<C-U>tabe $MYVIMRC<CR>
nnoremap <F9>  :<C-U>tabe <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/after/ftplugin/
nnoremap <Leader><F9> :<C-U>tabe <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/plugin/
"fill a part of the path to vim files
cnoremap <F9> <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/plugin/
cnoremap <F10> <C-R>=fnamemodify(expand("$MYVIMRC"), ":h")<CR>/


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

"other movement
"if moving more than 3 lines at once, populate the jumplist
"also move by true lines when count given, and by screen lines otherwise
nnoremap <expr> k v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'k' : 'gk'
xnoremap <expr> k v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'k' : 'gk'
nnoremap <expr> j v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'j' : 'gj'
xnoremap <expr> j v:count ? (v:count > 3 ? ("m'" . v:count) : '') . 'j' : 'gj'
"because 0 is easier to press
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
xnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
onoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
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


"helpful for search and regexps
cnoremap ;( \(\)<Left><Left>
cnoremap ;) \(\)<Left><Left>
cnoremap ;< '\<\>'<Left><Left><Left>
cnoremap ;> \<\><Left><Left>

"hotkeys for moving tabs
nnoremap <silent> gmt :<C-U>tabm +1<CR>
nnoremap <silent> gmT :<C-U>tabm -1<CR>
"Fucking Nice (took me a long time to think of it)
nnoremap <Space>t gT

"easily split lines
nnoremap <Space>o i<CR><Esc>

"open tag and let you choose the location; essentially a case sensitive g_^]
nnoremap <silent> <Space>] :exec "tjump /\\C^" . expand("<cword>") . "$"<cr>

"found i use <C-W> a lot, but it's a pain to press
nmap     <Space>w <C-W>

"quickly move between windows
nnoremap <Space>h <C-W>h
nnoremap <Space>j <C-W>j
nnoremap <Space>k <C-W>k
nnoremap <Space>l <C-W>l


"some remaps to control completion
inoremap <expr> <C-C> pumvisible() ? "\<C-E>" : "\<C-C>"
inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>\<C-P>"
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-X>\<C-U>\<C-P>\<C-P>"


"a map to copy buffer in new tab
nnoremap <C-W>t :tab split<CR>

"close current tab
nnoremap <C-W>c :tabclose<CR>


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

"also gF is really useful and should be used everywhere
nnoremap gf gF


"reset relative number, sometimes it just isn't set
nnoremap <Leader>rn :setlocal relativenumber<CR>


"convenient for file commands
cnoremap <expr> ;; expand("%:h")
"convenient for greps
cnoremap <C-R>' '\<<C-R>"\>'


" make n always search forward and N backward
nnoremap <expr> n v:searchforward ? 'n' : 'N'
nnoremap <expr> N v:searchforward ? 'N' : 'n'
" make ; always search forward and , backward
nnoremap <expr> ; getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'


" split line on space under cursor (by drzel)
nnoremap <Space>o :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>


"abbreviation for easier topleft window opening
cabbrev <expr> tl (getcmdpos() == 3 && getcmdtype() == ":") ? "topleft" : "tl"
cabbrev <expr> la (getcmdpos() == 3 && getcmdtype() == ":") ? "leftabove" : "la"
"abbreviation for vertical split and find
cabbrev <expr> vsf (getcmdpos() == 4 && getcmdtype() == ":") ? "vert sfind" : "vsf"
"remake
cabbrev <expr> wmake (getcmdpos() == 6 && getcmdtype() == ":") ? "w <bar> make" : "wmake"


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


"cleanup of temp files
augroup undofile_cleanup
	autocmd!
	autocmd VimLeavePre * call <sid>tempfile_cleanup()
augroup END
fun! s:tempfile_cleanup()
	" remove files older than 30 days
	exec "!find " . &undodir . " -type f -mtime +30 -exec rm {} \\;"
endfun


augroup tempalates
	autocmd!
	autocmd BufNewFile *.py call <sid>read_template("python.py")
	autocmd BufNewFile stack.yaml call <sid>read_template("stack.yaml", 1, 10)
	autocmd BufNewFile package.yaml call <sid>read_template("package.yaml", 1, 21)
	autocmd BufNewFile Main.hs call <sid>read_template("Main.hs", 5, 7)
	autocmd BufNewFile *.cabal call <sid>read_template("cabal.cabal", 1, 21)
augroup END
fun! s:read_template(name, ...) abort
	exec ':0read ' . fnamemodify(expand("$MYVIMRC"), ":h")
		\ . '/templates/' . a:name

	" arg 1: line number
	if a:0 >= 1
		normal! Gdd
		let linenr = a:1
		exec 'normal! ' . linenr . 'G'
	else
		normal! G
	endif

	" arg 2: column number
	if a:0 >= 2
		let colnr = a:2
		exec "normal! " . colnr . "\<bar>"
	endif
endfun


if exists('g:started_by_firenvim')
	colorscheme shine
	set laststatus=0

	"disable undofile cleanup, it has ugly popup at end
	augroup undofile_cleanup
		autocmd!
	augroup END
endif
