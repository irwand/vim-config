" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"     for Amiga:  s:.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
   finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

try
   let g:plug_threads = 1 " otherwise gvim on win crashes
   call plug#begin()

   Plug 'altercation/vim-colors-solarized'
   Plug 'ctrlpvim/ctrlp.vim'
   Plug 'vim-scripts/DrawIt'
   Plug 'vim-scripts/Tab-Name'
   Plug 'qpkorr/vim-bufkill'
   Plug 'vim-scripts/DirDiff.vim'
   Plug 'csexton/trailertrash.vim'
   Plug 'msanders/snipmate.vim'
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-abolish'
   Plug 'tpope/vim-repeat'
   Plug 'tpope/vim-fugitive'
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'
   Plug 'vivien/vim-linux-coding-style'
   Plug 'tpope/vim-sensible'
   Plug 'nvie/vim-flake8'
   Plug 'nathanaelkane/vim-indent-guides'
   Plug 'klen/python-mode'

   "phindman's tools I need to look at
   "Plug 'terryma/vim-multiple-cursors'
   "Plug 'tpope/vim-dispatch'
   "Plug 'tpope/vim-unimpaired'

   "this is potentially slow
   "Plug 'Valloric/YouCompleteMe'

   call plug#end()
catch
   echom "Couldn't use Vim-Plug, install it?"
endtry

" === PLUGIN CONFIG BEGIN ===
let g:netrw_alto = 1
let g:netrw_altv = 1

let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

let g:pymode_lint_ignore = "E501" " disable line too long warning
let g:pymode_rope = 0             " disable rope, slow

let g:ctrlp_map = '<Leader>o'
nmap <Leader>b :CtrlPBuffer<cr>
set wildignore+=*.o,*.obj,*.pyc,*/.hg/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](objects|\.git|\.hg|\.svn)$',
  \ 'file': '\v\.(exe|so|dll|obj|o)$',
  \ }
let g:ctrlp_root_markers=['package','.git']

let g:linuxsty_patterns = [ "/usr/src/", "/linux", "/ni6683" ]

let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
" === PLUGIN CONFIG END ===

if has("unix")
   " create /tmp/$USER for tmp dir for temporary files
   silent !mkdir -p /tmp/$USER
   silent !chmod 700 /tmp/$USER
   set viminfo='32,f0,\"10,n/tmp/$USER/viminfo
   set grepprg=grep\ -n          " use grep program, starting vim 7, we should use vimgrep
   set shell=/bin/bash           " use bash shell by default
   set directory=/tmp/$USER      " set temporary directory for swap files
   set viewdir=/tmp/$USER        " set temporary directory for view files
else
   set viminfo='32,f0,\"10,n$TMP/viminfo
   set grepprg=$VIMRUNTIME\..\..\bin\grep.exe\ -n  " use grep program, starting vim 7, we should use vimgrep
   set shell=cmd.exe             " use standard cmd.exe on Windows
   set directory=$TMP            " set temporary directory for swap files
   set viewdir=$TMP              " set temporary directory for view files
   set renderoptions=type:directx
endif

" Set GUI appearance parameters
if has("gui_running")

   " TODO: Customize according to your preference
   if has("unix")
      set guifont=ProggySquareTTSZ\ 12
   else
      set guifont=ProggySquareTTSZ:h12:cANSI
   endif

   set mousehide                 " Hide the mouse when typing text
   set lines=60                  " set the window to be 60 lines by default
   set columns=90                " set the window to be 90 char wide by default

   " TODO: Set according to your preference !! ":help guioptions" for
   " more info. agrb below: autoselect, right hand scrollbar, bottom
   " scrollbar, no menu, no toolbar
   set guioptions=aAe

   " this needs to be set before map cmds
   set encoding=utf-8

endif

" Set diff parameters
if &diff
   if has("gui_running")
      set columns=180            " if in guimode, open the window 180 columns wide
   endif
endif
set diffopt=filler,iwhite,vertical " ignore whitespace, show filler line, vertical split


" Set editing parameters
set foldlevel=99                 " don't fold anything by default
set visualbell                   " visual bell instead of annoying beeping
set showmatch                    " show parentheses match
set nobackup                     " no backup file, those annoying files with '~' char
set list                         " always in list mode to show unseen chars

" TODO: decide if you like to set filename completion to be like bash
set wildmode=longest:full

" Set wrap parameters
set nowrap                       " don't wrap by default
set linebreak                    " if using wrap mode, break on fullword
set showbreak=+\                 " in wrap mode, prefix "+ " on the next line

" Set split parameter: where to put the new window upon split
set splitbelow
set splitright

" Set completion parameter
set showfulltag                  " when completing a word in insert mode,
                                 " show tag name and search pattern

" Set tab & indent options
set expandtab                    " insert spaces instead of tabs in insert mode
set shiftwidth=3                 " shift distance, mainly for >> or << command
set shiftround                   " When shifting, round indent distance by multiple shiftwidth
set tabstop=3                    " tabstop

" TODO: Change the following according to your preference!
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,t0,c3,+s,(s,us,)20,*30,gs,hs
set cinkeys=0{,0},:,!^F,o,O,e

" Set search options
set ignorecase                   " ignore case during search
set smartcase                    " smart case match, read ":help smartcase" for more info
set hlsearch                     " highlight last search, use ":nohl" to temporarily stop highlighting

" Set buffering options
set hidden                       " Lets you switch buffer without saving

" Set view options for mkview and loadview
set viewoptions=cursor,folds     " Only remember cursor position and folds

" setting wildchar expansion option
set suffixes=.bak,.obj,.swp,.info,.o   " excludes the following suffixes in filename completion

" Set path to search child dirs (...)
set path=**                      " search path for gf, :find, etc

" TODO: Set key mappings. Customize the following depending on your preference
mapclear

" cursor movements
map <Home> 0
map <End> $
map <C-Left> b
map <C-Right> w
map <C-Home> 1G
map <C-End> G$

" Ctrl Q to quit all
nmap <C-q> :qa<cr>

" iterate over tag definition, help tags for more info
nmap <C-n> :tn<cr>
nmap <C-p> :tp<cr>

" These mappings below uses two different cases, because vim on regular
" terminal does not understand meta char, so we have to use <esc>

" iterate over error file or grep result
if has("gui_running")
   nmap <M-n> :cn<cr>
   nmap <M-p> :cp<cr>
else
   nmap <esc>n :cn<cr>
   nmap <esc>p :cp<cr>
endif

" map alt-j,k,h,l to switch move between windows. ":help windows" for more info
if has("gui_running")
   nmap <M-l> <C-w><Right>
   nmap <M-h> <C-w><Left>
   nmap <M-k> <C-w><Up>
   nmap <M-j> <C-w><Down>
else
   nmap <esc>l <C-w>l
   nmap <esc>h <C-w>h
   nmap <esc>k <C-w>k
   nmap <esc>j <C-w>j
endif

" go to next and previous buffer. To switch rapidly btw 2 buffers, use Ctrl-6
if has("gui_running")
   map <M-.> :bnext<cr>
   map <M-,> :bprevious<cr>
else
   map <esc>. :bnext<cr>
   map <esc>, :bprevious<cr>
endif

" map ctrl-backspace to delete prev word in insert mode
imap <C-BS> <C-W>

" map Alt-8 to grep for the current word in the subdirectories. Why alt-8?
" because shift-8, or the '*' is to search for the current word in the current
" file. modify g:sourceDir variable if you want to not search in source/ dir.
" Crap.. vim 7 supports vimgrep, but this thing is a bit slow now. Maybe we'll
" use vimgrep in the future.
let g:sourceDir="source/"
if has("gui_running")
   map <expr> <M-8> ":grep -rw <cword> " . g:sourceDir . "*<cr>"
else
   map <expr> <esc>8 ":grep -rw <cword> " . g:sourceDir . "*<cr>"
endif

" Completion.. From vim.org Tip #102: smart mapping for tab completion during
" insert mode
function! InsertTabWrapper(direction)
   let col = col('.') - 1
   if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
   elseif "backward" == a:direction
      return "\<c-p>"
   else
      return "\<c-n>"
   endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper("backward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper("forward")<cr>

" TODO: determine the leader character you like. Default is '\', but ',' seems
" more easily accessible
let mapleader=","

fun! PerforceBlame()
execute "!python c:/bin/p4_introduced.py " . bufname("%") . " " . line(".")
endfun

" TODO: perforce mapping. Comment these lines below if you use perforce plugin
nmap <Leader>pa :!p4 add "%"<cr>
nmap <Leader>pe :!p4 edit "%"<cr>:e!<cr>
nmap <Leader>pr :!p4 revert "%"<cr>:e!<cr>
nmap <Leader>ps :!p4 sync "%"<cr>:e!<cr>
nmap <Leader>pu :!p4 submit<cr>:e!<cr>
nmap <Leader>pb :call PerforceBlame()<cr>

" this maps ,e to ":e <path to current file>" handy for opening new files
if has("unix")
   nmap <Leader>e :e <C-R>=expand("%:h")."/"<CR>
else
   nmap <Leader>e :e <C-R>=expand("%:h")."\\"<CR>
endif

" this maps ,tl to switch to the last tab, handy for working with tabs
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Only do this part when compiled with support for autocommands.
if has("autocmd")
   " for CPP, C, IPP, ipp files, set the filetype accordingly for syntax
   " highlighting
   au BufNewFile,BufRead *.CPP setfiletype cpp
   au BufNewFile,BufRead *.C setfiletype c
   au BufNewFile,BufRead *.IPP setfiletype cpp
   au BufNewFile,BufRead *.ipp setfiletype cpp

   " for mako file, treat them like html
   au BufNewFile,BufRead *.mako setfiletype html

   " For all files set 'textwidth' to 78 characters.
   "autocmd FileType * setlocal textwidth=78

   " automatically remove trailing whitespace before write
   autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :TrailerTrim

   " When editing a file, always jump to the last known cursor position.
   " Don't do it when the position is invalid or when inside an event handler
   " (happens when dropping a file on gvim).
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

   " set omnifunc to be based on syntax files, if omnifunc is not defined for
   " the file
   if has("autocmd") && exists("+omnifunc")
   autocmd Filetype *
      \  if &omnifunc == "" |
      \     setlocal omnifunc=syntaxcomplete#Complete |
      \  endif
   endif

   " Highlight some nasty keywords with ugly colors
   autocmd BufReadPost * syn keyword myBUG containedin=ALL BUG TODO IKDTODO IKDBUG IKDHACK IKDNOTE
   autocmd BufReadPost * hi myBUG guibg=#808000 guifg=#ffff00

   " auto reload vimrc
   augroup reload_vimrc " {
      autocmd!
      autocmd BufWritePost $MYVIMRC source $MYVIMRC
   augroup END " }
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   if has("gui_running")
      " color theme, look at VIM tip #693 to see the available color themes
      " Download the color theme and use it down here
      " Another good one: http://ethanschoonover.com/solarized
      colorscheme solarized
   else
      set background=dark
   endif
   syntax on
endif

" TODO: Uncomment this below if you want VIM to behave more like MSWin editor:
" Ctrl-A select all, Ctrl-V paste, Ctrl-C copy, etc
"source $VIMRUNTIME/mswin.vim
