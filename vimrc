" Things I chose that are in sensible.vim

filetype plugin indent on

set autoindent

set incsearch

set tabpagemax=50

" New things from sensible.vim that I'm OK with
set showmatch
set smarttab

set nrformats-=octal
set shiftround

set autoread
set fileformats+=mac

set history=1000
set viminfo^=!


nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

set laststatus=2
set showcmd
set wildmenu

set sidescrolloff=5
set display+=lastline

" What the fuck does this do?
inoremap <C-U> <C-G>u<C-U>

" Things from sensible.vim that seem to be set anyway
set backspace=indent,eol,start
set ruler
set encoding=utf-8

" Things from sensible.vim that I don't like the sound of but I'm trying
set complete-=i
" set ttimeout
" set ttimeoutlen=50
" different listchars

" Not in sensible.vim and disabled to see if I miss it
set wildmode=list:longest

" Unclassified / my views differ from Tim Pope's

set hidden
set nobackup
set scrolloff=4
set splitright

" GUI stuff
if has("gui_running")
    colorscheme desert
    set guifont=Monospace\ 11
    " Hide toolbar
    set guioptions-=T

    set number
endif

" For Python
set expandtab
set list
set listchars=trail:.,tab:>- 
set nowrap
set shiftwidth=4
set tabstop=4

" For Vala
" FIXME: is there a way to do this using Pathogen.vim automatically?
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead,BufNewFile *.vala,*.vapi setfiletype vala
