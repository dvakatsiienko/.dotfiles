"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                              "
" Maintainer: Dima Midnight <imagnum.satellite@gmail.com>                                         "
"        URL: http://github.com/mike-midnight/.dotfiles                                           "
"                                                                                                 "
"                                                                                                 "
" Sections:                                                                                       "
"   01. General ....................... General Vim behavior                                      "
"   02. Plugins ....................... List of plugins for install                               "
"   03. Plugins settings .............. Plugins settings                                          "
"   04. Autocommands .................. Autocmd events                                            "
"   05. UI ............................ Syntax, colors, fonts, etc                                "
"   06. Text Formatting/Layout ........ Text, tabs, indentation related                           "
"   07. Mappings ...................... Vim mappings                                              "
"   08. Abbreviations ................. Custom abbreviation                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                      " Disables Vi compatibility (much better!)
set encoding=utf-8
set hidden                            " Hides buffers instead of closing them when
set history=1000                      " Remember more commands and search history
set undolevels=1000                   " Use many levels of undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Plugins                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'L9'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}

call vundle#end()
filetype plugin indent on

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Plugins settings                                                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Autocommands                                                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile * :write
autocmd BufNewFile,BufRead *.html setlocal nowrap

augroup filetype_js
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType javascript iabbrev  <buffer> iff if ()
    autocmd FileType javascript iabbrev  <buffer> log console.log('λ', );<left>
    autocmd FileType javascript iabbrev  <buffer> conts const
    autocmd FileType javascript iabbrev  <buffer> cotns const
    autocmd FileType javascript iabbrev  <buffer> fu function
    autocmd FileType javascript iabbrev  <buffer> fuction function
augroup END

augroup filetype_py
    autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python     iabbrev  <buffer> iff if:<left>
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. UI                                                                                          "
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
set ignorecase                       " Searches are case insensitive...
set smartcase                        " ... unless they contain at least one capital letter

syntax enable
colorscheme murphy
set t_Co=256                         " Enable 256-color mode.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype indent on                   " Activates indenting for files <-- ?
set backspace=indent,eol,start
set autoindent                       " Alwayis set autoindenting on
set tabstop=4 shiftwidth=4           " Tab spacing
set smarttab                         " Insert tabs on the start of a line according to shiftwidth
set softtabstop=4                    " Use spaces count by using TAB
set shiftround                       " Use multiple of shiftwidth when indenting with '<' and '>'
set expandtab                        " Use spaces instead of tab

set nowrap                           " Wrap lines
set wrapmargin=100                   " Line length
set textwidth=100
set colorcolumn=100                  " Code margin indicator + color
highlight ColorColumn ctermbg=magenta

set showmatch                        " Show matching parenthesis
set matchtime=5

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Mappings                                                                                    "
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
" 07. Abbreviations                                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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



" "TODO"
" 1. Wrapper for word
" 2. Multiline insert and edit
" 3. Multiline identation
" 4. Improve Comment hotkey in order to uncomment automatically
" 7. Dot-like empty spaces before start of line

