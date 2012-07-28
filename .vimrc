" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Jan 06
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"		for VMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set backspace=2		" (bs) allow backspacing over everything in insert mode
set viminfo='20,\"50	" (vi) read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=50		" (hi) keep 50 lines of command line history
set ruler		" (ru) show the cursor position all the time
set cindent
set sm
set nu
set nobackup
set guifont=Terminus:h16
set expandtab 
set tabstop=4       " number of spaces a tab takes
set shiftwidth=4    " depth of auto indentation
set smarttab
set scrolloff=4
set scroll=3 "for C-D, C-U
set formatoptions=tcqrn

filetype indent on

set guioptions-=T

set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

map <F4> :set hls!<CR>
map <F6> :set nu!<CR>

set nohls

filetype plugin indent on
syntax on

if version < 700
set list listchars=tab:>-,trail:⋅,nbsp:⋅
else
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
endif


set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set laststatus=2        "always display status line"
filetype plugin indent on
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendly

"This is the common (original) part. If it is not necessary do not edit it.
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

if has("cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

syntax on
colorscheme torte
set autoindent
set pastetoggle=<F12>
