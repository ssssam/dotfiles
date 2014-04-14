" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

let g:pymode_folding = 0
let g:pymode_lint_on_write = 0
let g:pymode_trim_whitespaces = 0

" Workaround for https://github.com/klen/python-mode/issues/405
let g:pymode_rope = 0

" UI stuff
set hidden
set nobackup
set scrolloff=4
set splitright
set wildmode=list:longest

" GUI stuff
if has("gui_running")
    colorscheme desert
    set guifont=Monospace\ 11
    " Hide toolbar
    set guioptions-=T

    set number
endif

" Editing defaults. Filetype-specific overrides go in
" .vim/ftplugin/$FILETYPE.vim
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
