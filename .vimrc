echo "(>^.^<)"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                              "
" Maintainer: Dima Midnight <imagnum.satellite@gmail.com>                                         "
"        URL: http://github.com/mike-midnight/.dotfiles                                           "
"                                                                                                 "
"                                                                                                 "
" Sections:                                                                                       "
"   01. General ................. General Vim behavior                                            "
"   02. Autocommands .............Autocmd events                                                  "
"   03. UI ...................... Syntax, colors, fonts, etc                                      "
"   04. Text Formatting/Layout .. Text, tabs, indentation related                                 "
"   05. Mappings ................ Vim mappings                                                    "
"   06. Abbreviations ........... Custom abbreviation                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                      " Disables Vi compatibility (much better!)
set hidden                            " Hides buffers instead of closing them when
set history=1000                      " Remember more commands and search history
set undolevels=1000                   " Use many levels of undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile * :write
autocmd BufNewFile,BufRead *.html setlocal nowrap
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. UI                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set fullscreen                        " MacVim automatic fullscreen mode on file open
set fuopt+=maxhorz                    " Grow to maximum screen size on entering fullscreen mode


set ruler                             " Show the line and column number of the cursor position
set number
set relativenumber
set numberwidth=2

set laststatus=2                     " Last window always has a statusline
set nohlsearch                       " Don't continue to highlight searched phrases.
set incsearch                        " But do highlight as you type your search.


syntax enable
colorscheme murphy
set t_Co=256                         " Enable 256-color mode.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Text Formatting/Layout                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype indent on                   " Activates indenting for files <-- ?
set backspace=indent,eol,start
set autoindent                       " Alwayis set autoindenting on
set tabstop=4                        " Tab spacing
set softtabstop=4                    " Use spaces count by using TAB
set shiftwidth=4                     " Number of spaces to use for indenting with '<' and '>'
set shiftwidth=4                     " Indent/outdent by 4 columns
set shiftround                       " Use multiple of shiftwidth when indenting with '<' and '>'
set expandtab                        " Use spaces instead of tab
set smarttab                         " Insert tabs on the start of a line according to shiftwidth
                                     " not tabstop

set wrap                             " Wrap lines
set wrapmargin=100                   " Line length
set textwidth=100
set colorcolumn=100                  " Code margin indicator + color
highlight ColorColumn ctermbg=magenta

set showmatch                        " Show matching parenthesis
set matchtime=5

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Mappings                                                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <Esc> <nop>

" Insert mode arrows ABCD fix
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
      inoremap <silent> <C-[>OC <RIGHT>
  endif

inoremap  <up>     <nop>
inoremap  <right>  <nop>
inoremap  <down>   <nop>
inoremap  <left>   <nop>
noremap   <up>     <nop>
noremap   <right>  <nop>
noremap   <down>   <nop>
noremap   <left>   <nop>

let mapleader = "\\"
let maplocalleader = ","
inoremap <up> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

noremap - ddp
noremap _ ddkP
nnoremap + O<Esc>
nnoremap = o<Esc>k
nnoremap 9 kdd
nnoremap 8 jddk

inoremap jk <Esc>
inoremap <c-u> <Esc>viwU<Esc>
nnoremap <c-u> viwU

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

nnoremap H o<Esc>ddk
nnoremap L $

vnoremap q <Esc>`<i'<Esc>`>a'<Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Abbreviations                                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev log console.log('λ', );
iabbrev conts const
iabbrev conts const
iabbrev cotns const
iabbrev f function
iabbrev fuction function
iabbrev swtich switch
iabbrev swithc switch
iabbrev swithc switch
iabbrev r return
iabbrev retrun return

iabbrev improt import
iabbrev impotr import
iabbrev exprot export
iabbrev exprtr export
iabbrev ed export deafult

iabbrev tehn then
iabbrev calls class
iabbrev claas class
iabbrev extneds extends

iabbrev extedns extends
iabbrev extedns extends
iabbrev Componetn Component

iabbrev @@ imagnum.satellite@gmail.com

" •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••


" "TODO"
" 1. Wrapper for word
" 2. Multiline insert and edit
" 3. Multiline identation
" 4. Improve Comment hotkey in order to uncomment automatically
" 5. Investigate :soruce saving problem inside .vimrc
" 6. Investigate inserting strange symbols while pressing arrows in insert mode
" 7. Dot-like empty spaces before start of line

