" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

let g:pymode_folding = 0
let g:pymode_lint_on_write = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_python = 'python3'

" Workaround for https://github.com/klen/python-mode/issues/405
let g:pymode_rope = 0

" UI stuff
set belloff=all
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
else
    " QBASIC AND FUCK THE WORLD
    colorscheme blue
    " FUCK OFF MOUSE TERMINAL INTEGRATION YOU'RE SO ANNOYING
    set mouse-=a
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

" Map :W to :w. (I regularly mistype it).
command W w

" NetRW (file browser) configuration
" - browse tree style by default
let g:netrw_liststyle=3

" Unite.vim configuration
"   - based on http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>

" \b is a more awkward combination, but it kind of makes more sense for the
" 'view buffer' command!
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>f :<C-u>UniteWithBufferDir -no-split -buffer-name=files -start-insert file<cr>

nnoremap Q <nop>
