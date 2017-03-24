"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                              "
" Maintainer: Dima Midnight <imagnum.satellite@gmail.com>                                         "
"        URL: http://github.com/mike-midnight/.dotfiles                                           "
"                                                                                                 "
"                                                                                                 "
" Sections:                                                                                       "
"   01. General ....................... General Vim behavior                                      "
"   02. UI ............................ Syntax, colors, fonts, etc                                "
"   03. Autocommands .................. Autocmd events                                            "
"   04. Layout ........................ Text, tabs, indentation related                           "
"   05. Mappings: editing ............. General text editing                                      "
"   06. Mappings: layout .............. Major layout editing: inserting/replacing lines etc...    "
"   07. Abbreviations ................. Custom abbreviation                                       "
"   08. Plugs ....................... List of plugins for install                               "
"   09. Plugs settings .............. Plugins settings                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                      " Disables Vi compatibility (much better!)
set encoding=utf-8
set hidden                            " Hides buffers instead of closing them when
set history=200                       " Remember more commands and search history
set undolevels=1000                   " Use many levels of undo
set wildmenu                          " Command-line completion operates in an enhanced mode
set wildmode=list:longest             " Completion mode that is used for wildchar character
set visualbell                        " Use visual bell instead of beeping
set undofile                          " Gives the ability to undo file even after closing it
set shell=/bin/zsh
set ttyfast                           " Indicates a fast terminal connection, improves performance
set path+=**

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. UI                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark

" Gruvbox
let g:gruvbox_contrast_dark='dark'
let g:gruvbox_contrast_light='soft'

let g:gruvbox_invert_selection=0
let g:gruvbox_italicize_comments=0

" Molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Base16
let base16colorspace=256

if has("gui_macvim")
	set fullscreen                   " MacVim automatic full screen mode on file open
	set fuopt+=maxhorz               " Grow to maximum screen size on entering full screen mode
endif

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h14

syntax enable

set t_Co=256                         " Enable 256-color mode.

set ruler                            " Show the line and column number of the cursor position
set number
set relativenumber
set numberwidth=2
set cursorline

set laststatus=2                     " Last window always has a status line

set ignorecase                       " Searches are case insensitive...
set smartcase                        " ... unless they contain at least one capital letter
set incsearch                        " But do highlight as you type your search.
set showmatch
set nohlsearch                       " Do not continue to highlight searched phrases.

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
" 03. Layout                                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab ball                           " Opens a new tab for each open buffer

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
" 04. Autocommands                                                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has ('autocmd')

	autocmd BufNewFile * :write
	autocmd BufNewFile,BufRead *.html setlocal nowrap

	autocmd FocusLost * :wa

	" Vimscript file settings ---------------------- {{{
	augroup filetype_vim
		autocmd!
		autocmd FileType vim setlocal foldmethod=marker
	augroup END
	" }}}

	augroup filetype_js
		autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
	augroup END

	augroup filetype_js
		autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
		autocmd FileType javascript iabbrev  <buffer> iff if ()
		autocmd FileType javascript iabbrev  <buffer> log console.log('λ', );
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

endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Mappings: editing                                                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\<space>"
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

" Adds period to visual mode
vnoremap . :norm.<CR>

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

" Navigate over splits with hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Strip whitespaces in current line
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Surround word with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel

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

" Put a semicolong in the end of a line
nnoremap <leader>; mqA;<esc>`q

" Grep operation over current word
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 20<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Mappings: layout                                                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap - ddp
nnoremap _ ddkP
nnoremap <leader>+ O<Esc>
nnoremap <leader>= o<Esc>k
nnoremap 9 kdd
nnoremap 8 jddk

" Create a ======= line below or above a cursor
nnoremap <leader>1 yypVr=k
nnoremap <leader>2 yyPVr=j

" Autoident current line, or selection

" nnoremap <leader>= =
" vnoremap <leader>= =

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 07. Abbreviations                                                                               "
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 08. Plugs                                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" vim-markdown and it's dependency - tabular
Plug 'godlygeek/tabular', { 'for': 'markdown'}
Plug 'plasticboy/vim-markdown', { 'for': 'markdown'}

" Color schemes
Plug 'morhetz/gruvbox'
" Plug 'tomasr/molokai'
" Plug 'sjl/badwolf'
" Plug 'nanotech/jellybeans.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'ascenator/L9', {'name': 'newL9'}

" devicons should be loaded after all other dependent plugins
Plug 'ryanoasis/vim-devicons'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 09. Plugs settings                                                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

"--------------------------------------------------------------------------------------------------
" ••••••••••••••••••••••••••••••••••••••• NERDTree ••••••••••••••••••••••••••••••••••••••••••••••••
"--------------------------------------------------------------------------------------------------
augroup vimenter
    
    " open a NERDTree automatically when vim starts up if no files were specified
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    
    " prevents NERDTree from hiding when first selecting a file
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    
augroup END

" custom arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <Leader>n <plug>NERDTreeTabsToggle<CR>

let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksFile = $HOME . '/.dotfiles/.vim/meta/NERDTree/.NERDTreeBookmarks'
let NERDTreeShowHidden = 1


"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞

"--------------------------------------------------------------------------------------------------
" ••••••••••••••••••••••••••••••••••••••• Markdown ••••••••••••••••••••••••••••••••••••••••••••••••
"--------------------------------------------------------------------------------------------------

"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞

"--------------------------------------------------------------------------------------------------
" ••••••••••••••••••••••••••••••••••••••• Devicons ••••••••••••••••••••••••••••••••••••••••••••••••
"--------------------------------------------------------------------------------------------------

let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:webdevicons_conceal_nerdtree_brackets = 1

"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞

colorscheme gruvbox

" "TODO"
" 1. Transfer functions to separate files in `bundle` ans save those in dotfiles
" 2. Wrapper for word
" 3. Multiline insert and edit
" 4. Multiline identation
" 5. Improve Comment hotkey in order to uncomment automatically
" 6. Dot-like empty spaces before start of line
" 7. investigate filetype option over vimrc file

