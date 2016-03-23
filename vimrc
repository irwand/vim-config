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

endif

" Set diff parameters
if &diff
   if has("gui_running")
      set columns=180            " if in guimode, open the window 180 columns wide
   endif
endif
set diffopt=filler,iwhite,vertical " ignore whitespace, show filler line, vertical split

" Set editing parameters
set visualbell                   " visual bell instead of annoying beeping
set showmatch                    " show parentheses match
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set nobackup                     " no backup file, those annoying files with '~' char
set history=50                   " keep 50 lines of command line history
set listchars=tab:>-,trail:$,extends:>,precedes:< " chars to use during "set list" mode
set list                         " always in list mode to show unseen chars


" Set status line appearance
set laststatus=2                 " window will always have status line
set ruler                        " have current cursor position in status line
set showcmd                      " show command in status line
set showmode                     " show current mode in the status line
set wildmenu                     " show possible matches on the status line

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
set complete=.,w,b,u,t           " Set complete-ion files to search. Currently
                                 " scanning included files is slow. default
                                 " is:.,w,b,u,t,i in vim7. 'i' is new: scan
                                 " included files
set showfulltag                  " when completing a word in insert mode,
                                 " show tag name and search pattern

" Specify scrolling offset. Uncomment and edit the number according to your
" preference below.
"set sidescroll=5
"set sidescrolloff=5
"set scrolloff=5

" Set tab & indent options
set expandtab                    " insert spaces instead of tabs in insert mode
set smarttab                     " :help smarttab
set shiftwidth=3                 " shift distance, mainly for >> or << command
set shiftround                   " When shifting, round indent distance by multiple shiftwidth
set tabstop=3                    " tabstop

" Set smartindent feature
set autoindent                   " auto indent next line according to this line
"set smartindent                  " smart auto indent. NOTE: DO NOT USE THIS, it messes up stuff. Read docs.

" TODO: Change the following according to your preference!
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,t0,c3,+s,(s,us,)20,*30,gs,hs
set cinkeys=0{,0},:,!^F,o,O,e

" Set search options
set ignorecase                   " ignore case during search
set smartcase                    " smart case match, read ":help smartcase" for more info
set hlsearch                     " highlight last search, use ":nohl" to temporarily stop highlighting
set incsearch                    " do incremental searching

" Set buffering options
set hidden                       " Lets you switch buffer without saving

" Set view options for mkview and loadview
set viewoptions=cursor,folds     " Only remember cursor position and folds

" setting wildchar expansion option
set suffixes=.bak,.obj,.swp,.info   " excludes the following suffixes in filename completion

" Set tag file locations (NOTE: "tags;" make VIM search parents)
" Do ":help file-searching" to get more info
set tags=tags;

" Set path to search child dirs (...)
set path=**                      " search path for gf, :find, etc

" Some parameters to customize some plugins or scripts
"let perl_fold=1                 " Use perl folding. Uncomment to enable
let g:html_tag_case="l"          " html.vim: use lower case html tags
let g:no_html_toolbar="no"       " html.vim: don't use toolbar
let Tlist_Inc_Winwidth = 0       " taglist.vim: don't resize during Tlist

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
if version >= 700
   if has("gui_running")
      map <expr> <M-8> ":grep -rw <cword> " . g:sourceDir . "*<cr>"
   else
      map <expr> <esc>8 ":grep -rw <cword> " . g:sourceDir . "*<cr>"
   endif
else
   if has("gui_running")
      map <expr> <M-8> ":grep -rw <cword> " . g:sourceDir . "*<cr>"
   else
      map <expr> <esc>8 ":grep -rw <cword> " . g:sourceDir . "*<cr>"
   endif
endif


" browsing
let g:netrw_alto = 1
let g:netrw_altv = 1


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

" mapping to make movements operate on 1 screen line in wrap mode
" Unfortunately, this only works on vim 7. Please use vim7 to enable this
if version >= 700
   function! ScreenMovement(movement)
      if &wrap
         return "g" . a:movement
   else
         return a:movement
      endif
   endfunction
   onoremap <silent> <expr> j ScreenMovement("j")
   onoremap <silent> <expr> k ScreenMovement("k")
   onoremap <silent> <expr> 0 ScreenMovement("0")
   onoremap <silent> <expr> ^ ScreenMovement("^")
   onoremap <silent> <expr> $ ScreenMovement("$")
   nnoremap <silent> <expr> j ScreenMovement("j")
   nnoremap <silent> <expr> k ScreenMovement("k")
   nnoremap <silent> <expr> 0 ScreenMovement("0")
   nnoremap <silent> <expr> ^ ScreenMovement("^")
   nnoremap <silent> <expr> $ ScreenMovement("$")
endif

" TODO: determine the leader character you like. Default is '\', but ',' seems
" more easily accessible
let mapleader=","

" got these functions below from scratch.vim, and modified it
function! MarkCurrentBufferToBeScratch()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal buflisted
endfunction

function! OpenOrCreateScratchBuffer(bufName)
    " Check whether the scratch buffer is already created
    let scr_bufnum = bufnr(a:bufName)
    if scr_bufnum == -1
        " open a new scratch buffer
         exe "new " . a:bufName
         call MarkCurrentBufferToBeScratch()
    else
        " Scratch buffer is already created. Check whether it is open
        " in one of the windows
        let scr_winnum = bufwinnr(scr_bufnum)
        if scr_winnum != -1
            " Jump to the window which has the scratch buffer if we are not
            " already in that window
            if winnr() != scr_winnum
                exe scr_winnum . "wincmd w"
            endif
        else
            exe "split +buffer" . scr_bufnum
        endif
    endif
endfunction

function! ExecuteCommandAndDumpOutputToScratchBuffer(cmd,bufName)
    call OpenOrCreateScratchBuffer(a:bufName)
    :%delete
    exe a:cmd
    :1
endfunction

" TODO: perforce mapping. Comment these lines below if you use perforce plugin
nmap <Leader>pa :!p4 add "%"<cr>
nmap <Leader>pe :!p4 edit "%"<cr>:e!<cr>
nmap <Leader>pr :!p4 revert "%"<cr>:e!<cr>
nmap <Leader>ps :!p4 sync "%"<cr>:e!<cr>
nmap <Leader>pu :!p4 submit<cr>:e!<cr>
nmap <Leader>pf :call ExecuteCommandAndDumpOutputToScratchBuffer("r!p4 filelog -L -s -i ".expand('%'),"p4scratch")<cr>
nmap <Leader>pd :call ExecuteCommandAndDumpOutputToScratchBuffer("r!p4 describe -du ".expand('<cword>'),"p4scratch")<cr>
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

" Dealing with ctrlp.vim
let g:ctrlp_map = '<c-f1>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*.o,*.obj,*.pyc,*/.hg/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](objects|\.git|\.hg|\.svn)$',
  \ 'file': '\v\.(exe|so|dll|obj|o)$',
  \ }


" Only do this part when compiled with support for autocommands.
if has("autocmd")
   " Enable file type detection.
   " Use the default filetype settings, so that mail gets 'tw' set to 72,
   " 'cindent' is on in C files, etc.
   " Also load indent files, to automatically do language-dependent indenting.
   filetype plugin indent on

   " I find html auto indenting annoying, so I disable it below. Comment these
   " lines if want them enabled.
   " autocmd BufEnter *.html setlocal indentexpr=
   " autocmd BufEnter *.shtml setlocal indentexpr=
   " autocmd BufEnter *.xml setlocal indentexpr=
   " autocmd BufEnter *.xhtml setlocal indentexpr=
   " Never mind, I made modifications to my own indent/html.vim

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
   function! StripTrailingWhitespace()
      normal mZ
      %s/\s\+$//e
      if line("'Z") != line(".")
         echo "Stripped trailing whitespace\n"
      endif
      normal `Z
   endfunction
   autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

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

   " Temporary settings
   au BufNewFile,BufRead *.shtml set wrap
   au BufNewFile,BufRead *.shtml set formatoptions-=t
   au BufNewFile,BufRead *.shtml set spell
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   set background=dark
   syntax on
endif

" TODO: color theme, look at VIM tip #693 to see the available color themes
" Download the color theme and use it down here
" Another good one: http://ethanschoonover.com/solarized
colorscheme solarized
"hi MatchParen guibg=darkgreen

" TODO: Uncomment this below if you want VIM to behave more like MSWin editor:
" Ctrl-A select all, Ctrl-V paste, Ctrl-C copy, etc
"source $VIMRUNTIME/mswin.vim
