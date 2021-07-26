unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

filetype plugin indent on

" Python Mode configuration
let g:pymode_folding = 0
let g:pymode_lint_on_write = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_python = 'python3'

" Workaround for https://github.com/klen/python-mode/issues/405
let g:pymode_rope = 0

" UltiSnips snippet engine configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

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
    set t_Co=256
    " BREAKS EVERYTHING :/
    " set termguicolors

    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    set background=dark    " Setting dark mode
    colorscheme deus
    let g:deus_termcolors=256

    " FUCK OFF MOUSE TERMINAL INTEGRATION YOU'RE SO ANNOYING
    set mouse-=a
endif

" Editing defaults. Filetype-specific overrides go in
" .vim/ftplugin/$FILETYPE.vim

" Visualize tabs by default.
set list
set listchars=trail:.,tab:>-

set nowrap

" Indent related flags. Default to Python style (no tabs).
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set copyindent
set preserveindent

" For Vala
" FIXME: is there a way to do this using Pathogen.vim automatically?
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead,BufNewFile *.vala,*.vapi setfiletype vala

" For Riot.js
autocmd BufRead,BufNewFile *.riot,*.tag setfiletype html

" Map :W to :w. (I regularly mistype it).
command W w

" NetRW (file browser) configuration
" - browse tree style by default
let g:netrw_liststyle=3

" I hit this key accidentally too much, disable it.
nnoremap Q <nop>

" Align params (using https://github.com/schaeferpp/vim-gnomealign)
map     ,a    :GNOMEAlignArguments<CR>

" Standup logs
function! Standup()
    execute "0,$s/^.*<\\w\\+> //"
endfunction

" Insert line below the cursor.
function! InsertLine(text)
    execute "normal! \<Esc>o".a:text
endfunction

" Insert a date header
function! DayWithSuffix()
    let _day=trim(strftime("%e"))

    if (_day == 1 || _day == 11 || _day == 21 || _day == 31) | let _prefix="st"
    elseif (_day == 2 || _day == 12 || _day == 22) | let _prefix="nd"
    elseif (_day == 3 || _day == 13 || _day == 23) | let _prefix="rd"
    else | let _prefix="th" | endif
    return _day._prefix
endfunction
:command! Date :call InsertLine(strftime("%A ").DayWithSuffix().strftime(" %B %Y").":\n")

" CTRL+j/k to move lines around
" From https://vimtricks.substack.com/p/vimtrick-moving-lines
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

" CTRL+h/l to move list elements around
" From https://vimtricks.substack.com/p/vimtrick-swap-arguments
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>
