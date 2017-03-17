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
"   06. Layout ........................ Text, tabs, indentation related                           "
"   07. Mappings: editing ............. General text editing                                      "
"   08. Mappings: layout .............. Major layout editing: inserting/replacing lines etc...    "
"   09. Abbreviations ................. Custom abbreviation                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                      " Disables Vi compatibility (much better!)
set encoding=utf-8
set hidden                            " Hides buffers instead of closing them when
set history=1000                      " Remember more commands and search history
set undolevels=1000                   " Use many levels of undo
set wildmenu                          " Command-line completion operates in an enhanced mode
set wildmode=list:longest             " Completion mode taht is used for wildchar character
set visualbell                        " Use visual bell instead of beeping
set undofile                          " Gives the ability to undo file even after closing it

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Plugins                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

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

au FocusLost * :wa

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

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

augroup filetype_md
    autocmd FileType markdown   onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rk0vg_"<cr>
    autocmd FileType markdown   onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. UI                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")
    set fullscreen                   " MacVim automatic fullscreen mode on file open
    set fuopt+=maxhorz               " Grow to maximum screen size on entering fullscreen mode
endif

set guifont=Menlo\ Regular:h13
syntax enable
colorscheme torte
set t_Co=256                         " Enable 256-color mode.

set ruler                            " Show the line and column number of the cursor position
set number
set relativenumber
set numberwidth=2
set cursorline
set ttyfast                          " Indicates a fast terminal connection, improves performance

set laststatus=2                     " Last window always has a statusline

set ignorecase                       " Searches are case insensitive...
set smartcase                        " ... unless they contain at least one capital letter
set incsearch                        " But do highlight as you type your search.
set showmatch
set hlsearch                         " Continue to highlight searched phrases.


set showmode                         " Show current modal editing mode
set showcmd                          " Show command in the last line of the screen

set statusline=\ λ
set statusline+=\ %4F                " Path to the file
set statusline+=\ •\                 " Separator
set statusline+=FileType:            " Label
set statusline+=%-4y                 " Filetype of the file
set statusline+=%=                   " Switch to the right side
set statusline+=\ Current:
set statusline+=\ %-4l               " Current line
set statusline+=\ Total:
set statusline+=\ %-4L               " Total lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Layout                                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab ball                           " Opens a new tab for each open buffer

filetype indent on                   " Activates indenting for files <-- ?
set backspace=indent,eol,start
set autoindent                       " Alwayis set autoindenting on
set tabstop=4                        " Tab spacing
set softtabstop=4                    " Delete spaces by one
set shiftwidth=4
set expandtab                        " Use spaces instead of tab

set nowrap                           " No wrap lines
set wrapmargin=100                   " Line length
set textwidth=100
set colorcolumn=100                  " Code margin indicator + color
highlight ColorColumn ctermbg=magenta

set showmatch                        " Show matching parenthesis
set matchtime=5

set scrolloff=3                      " Minimal number of screen lines to keep above and below cursor

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Mappings: editing                                                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = "\\"

" Insert mode arrows ABCD fix
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
      inoremap <silent> <C-[>OC <RIGHT>
  endif

set gdefault                         " Applies substitutions globally on lines

inoremap  <Esc> <nop>

inoremap  <up>     <nop>
inoremap  <right>  <nop>
inoremap  <down>   <nop>
inoremap  <left>   <nop>
noremap   <up>     <nop>
noremap   <right>  <nop>
noremap   <down>   <nop>
noremap   <left>   <nop>

inoremap  <up> <nop>
inoremap  <right> <nop>
inoremap  <down> <nop>
inoremap  <left> <nop>

nnoremap  <leader>ev :vsplit $MYVIMRC<cr>
nnoremap  <leader>sv :source $MYVIMRC<cr>

nnoremap ; :

inoremap jk <Esc>
nnoremap j gj
nnoremap k gk

" Uppercase a word
inoremap <c-u> <Esc>viwU<Esc>
nnoremap <c-u> viwU

nnoremap / /\v
nnoremap <tab> %

vnoremap / /\v
vnoremap <tab> %

vnoremap q <Esc>`<i'<Esc>`>a'<Esc>
vnoremap Q <Esc>`<i"<Esc>`>a"<Esc>

onoremap p i(
onoremap b /return<cr>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>

" Strip whitespaces in current line
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Surround word with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

nnoremap <leader>v :e ~/..vimrc<CR>
nnoremap <leader>v :tabnew ~/..vimrc<CR>

nnoremap <leader><space> :noh<cr>

" Fold HTML tag
nnoremap <leader>ft Vatzf

" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" Reselect line of text that was just pasted
nnoremap <leader>v V`]

" Open a split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Navigate over splits with hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 07. Mappings: layout                                                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap - ddp
nnoremap _ ddkP
nnoremap + O<Esc>
nnoremap = o<Esc>k
nnoremap 9 kdd
nnoremap 8 jddk

nnoremap <leader>1 yypVr=k
nnoremap <leader>2 yyPVr=j

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 08. Abbreviations                                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev fu function
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

" øøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøøø

" "TODO"
" 1. Wrapper for word
" 2. Multiline insert and edit
" 3. Multiline identation
" 4. Improve Comment hotkey in order to uncomment automatically
" 7. Dot-like empty spaces before start of line
" 8. investigate filetype option over vimrc file

