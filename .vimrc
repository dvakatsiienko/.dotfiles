echo "(>^.^<)"

set hidden             " hides buffers instead of closing them when. This means that you can have unwritten changes to a file and open a new file using :e, without being forced to write or undo your changes first.
set history=1000       " remember more commands and search history
set undolevels=1000    " use many muchos levels of undo

set number             " always show line numbers
set relativenumber
set numberwidth=2

set autoindent         " alwayis set autoindenting on
set tabstop=4          " quantity of spaces when tabbing
set shiftwidth=4       " number of spaces to use for indenting with '<' and '>' and autoindenting
set shiftround         " use multiple of shiftwidth when indenting with '<' and '>'

set smarttab           " insert tabs on the start of a line according to shiftwidth, not tabstop

set wrap               " wrap lines

set showmatch          " set show matching parenthesis
set matchtime=5        " Tenths of a second to show the matching paren, when 'showmatch' is set

nnoremap <space> za

map - ddp
map _ ddkP
imap jj <Esc>
