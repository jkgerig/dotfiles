"
" vimrc
"

" ---------------------------------------------------------------------------
" CONTENTS
" ---------------------------------------------------------------------------
"  1.   Vim Compatability Settings
"  2.   Vim-Plug Config
"  3.   General Configuration
"  4.   Filetype Specific
"  5.   Custom Functions
"  6.   Plugin Settings
" ---------------------------------------------------------------------------


" +=========================================================================+
" | 1. VIM COMPATABILITY SETTINGS                                           |
" +=========================================================================+

set nocompatible                    " VIM instead of vi settings
set backspace=indent,eol,start      " Make backspace delete over anything


" +=========================================================================+
" | 2. VIM-PLUG CONFIG                                                      |
" +=========================================================================+

" Specify directory for plugins
call plug#begin('~/.vim/plugged')

" Github Plugins
" ==========================================================================

" Solarized
Plug 'altercation/vim-colors-solarized'

" Vim Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

" Tabular
Plug 'godlygeek/tabular'

" Vim Markdown
Plug 'gabrielelana/vim-markdown'

" Initialize plugin system
call plug#end()


" +=========================================================================+
" | 3. GENERAL CONFIGURATION                                                |
" +=========================================================================+

" Colors
" ==========================================================================
colorscheme solarized               " Solarized colorscheme
let g:solarized_bold=0
call togglebg#map("<F5>")
set background=dark

set t_md=                           " NO bold font

" File Management
" ==========================================================================
set noundofile
set nobackup
set noswapfile

" Tabs
" ==========================================================================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set shiftround

" General Display
" ==========================================================================
set number
set relativenumber
set ruler
set cmdheight=2
set hlsearch
set showmode
set showcmd
set wildmenu
set wildignorecase
set showtabline=2
set hidden
set ignorecase
set smartcase
set splitbelow
set splitright
set linebreak

" Keymappings
" ==========================================================================
nmap <leader><Tab> :set expandtab!<CR>:set expandtab?<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>l :set list!<CR>
nmap <leader>b :buffers<CR>:buffer<Space>
nmap <leader>t :tabnew<CR>
nmap <silent> <leader>bd :bp\|bd #<CR>
nnoremap <leader><space> :noh<cr>

nnoremap <silent> h :tabprevious<CR>
nnoremap <silent> l :tabnext<CR>
nnoremap <silent> j :bn<CR>
nnoremap <silent> k :bp<CR>

nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sj :rightbelow new<CR>

set timeout timeoutlen=1500 ttimeoutlen=100


" +=========================================================================+
" | 4. FILETYPE SPECIFIC                                                    |
" +=========================================================================+

" HTML
" ==========================================================================
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2

" CSS
" ==========================================================================
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2


" +=========================================================================+
" | 5. CUSTOM FUNCTIONS                                                     |
" +=========================================================================+

" Keep tabs consistent. See: http://vimcasts.org/episodes/tabs-and-spaces/
" ==========================================================================
command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction

" Syntax highlighting under cursor
" ==========================================================================
map <F10> :echo "hi<"
            \ . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
            \ . ">"<CR>


" +=========================================================================+
" | 6. PLUGIN SETTINGS                                                      |
" +=========================================================================+

" vim-tmux-navigator
" ==========================================================================
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\e[3 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[1 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[1 q"
endif

