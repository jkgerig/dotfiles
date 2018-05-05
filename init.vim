"
" neovim config
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

" Automatically set in neovim:

"set nocompatible                    " VIM instead of vi settings
"set backspace=indent,eol,start      " Make backspace delete over anything

" +=========================================================================+
" | 2. VIM-PLUG CONFIG                                                      |
" +=========================================================================+

" Automatic install of vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Github Plugins
" ==========================================================================

" Solarized
"Plug 'altercation/vim-colors-solarized'

" NeoSolarized
Plug 'iCyMind/NeoSolarized'

" Vim Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

" Tabular
"Plug 'godlygeek/tabular'

" Vim Markdown
"Plug 'gabrielelana/vim-markdown'

" Thesaurus
Plug 'beloglazov/vim-online-thesaurus'

" Initialize plugin system
call plug#end()


" +=========================================================================+
" | 3. GENERAL CONFIGURATION                                                |
" +=========================================================================+

" Colors
" ==========================================================================
set termguicolors
set background=light
colorscheme NeoSolarized            " NeoSolarized colorscheme

" File Management
" ==========================================================================
set noundofile
set nobackup
set noswapfile

" Tabs
" ==========================================================================
"set autoindent                     " Automatic in neovim
set smartindent
"set smarttab                       " Automatic in neovim
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set shiftround

" General Display
" ==========================================================================
set number
set relativenumber
"set ruler                          " Neovim default
set cmdheight=2
set hlsearch
set showmode
"set showcmd                        " Neovim default
"set wildmenu                       " Neovim default
set wildignorecase
set showtabline=2
set hidden
set ignorecase
set smartcase
set splitbelow
set splitright
set linebreak

" Cursor Display
" ==========================================================================
" mode-list:argument-list
"     ^ dash-separated lists
" n - normal
" v - visual
" i - insert
" r - replace
"
" horN  - horizontal bar, N% height
" verN  - vertical bar, N% width
" block - block cursor, filled
"
" blinkwaitN    delay before cursor starts blinking
" blinkonN      time cursor is shown
" blinkoffN     time cursor is hidden
"
" group-name    highlight group name that sets color

set guicursor=n-v-sm:block-blinkon0
set guicursor+=i-ci:ver25-blinkwait400-blinkoff600-blinkon600
set guicursor+=r-cr-o-c:block-blinkwait400-blinkoff600-blinkon600

" Keymappings
" ==========================================================================
nmap <leader><Tab> :set expandtab!<CR>:set expandtab?<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>l :set list!<CR>
nmap <leader>b :buffers<CR>:buffer<Space>
nmap <leader>t :tabnew<CR>
nmap <silent> <leader>bd :bp\|bd #<CR>
nnoremap <leader><space> :noh<cr>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

nnoremap <silent> <M-h> :tabprevious<CR>
nnoremap <silent> <M-l> :tabnext<CR>
nnoremap <silent> <M-j> :bn<CR>
nnoremap <silent> <M-k> :bp<CR>

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

" gabrielelana/vim-markdown 
" ==========================================================================
let g:markdown_enable_conceal = 1

" beloglazov/vim-online-thesaurus
" ==========================================================================
let g:online_thesaurus_map_keys = 0
nnoremap <leader>k :OnlineThesaurusCurrentWord<CR>

augroup init
    autocmd!
    au VimLeave * set guicursor=a:block-blinkwait400-blinkoff600-blinkon600
augroup END

