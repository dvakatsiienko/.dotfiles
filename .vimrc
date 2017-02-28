echo "(>^.^<)"

" ###### VIM SETTINGS #####

set nocompatible          " Disables Vi comaptibility (much better!). Must be first, because it changes other options as a side effect.

set hidden             " hides buffers instead of closing them when. This means that you can have unwritten changes to a file and open a new file using :e, without being forced to write or undo your changes first.
set history=1000       " remember more commands and search history
set undolevels=1000    " use many muchos levels of undo

set ruler
set number
set relativenumber
set numberwidth=2
set t_Co=256              " enable 256-color mode.
syntax enable
colorscheme murphy
set laststatus=2          " last window always has a statusline
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.

filetype indent on        " activates indenting for files <-- ?
set autoindent         " alwayis set autoindenting on
set tabstop=4          " tab spacing
set softtabstop=4      " unify
set shiftwidth=4       " number of spaces to use for indenting with '<' and '>' and autoindenting
set shiftwidth=4       " indent/outdent by 4 columns
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab          " use spaces instead of tab

set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop

set wrap               " wrap lines

set showmatch          " set show matching parenthesis
set matchtime=5        " Tenths of a second to show the matching paren, when 'showmatch' is set

set list
set listchars=space:·
highlight WhiteSpaceBol guifg=blue
highlight WhiteSpaceMol guifg=white
match WhiteSpaceMol / /
2match WhiteSpaceBol /^ \+/

:let mapleader = "\\"
:let maplocalleader = "-"

noremap - ddp
noremap _ ddkP

inoremap jk <Esc>             " jj as <Esc> replacent
inoremap <c-u> <Esc>viwU<Esc> " Uppercase word from instert moden
nnoremap <c-u> viwU           " Uppercase word from instert moden

noremap <leader>d dd

