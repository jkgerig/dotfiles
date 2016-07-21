"
" vimrc
"

" Use Vim instead of Vi settings
set nocompatible

execute pathogen#infect()
call pathogen#helptags()

" always set autoindenting on
set ai

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Make backspace delete over anything
set backspace=indent,eol,start

" Color settings
" ==========================================================

syntax enable

set background=dark
"set background=light

colorscheme solarized
"colorscheme default

" ==========================================================
set undodir="~/.vim/undo//"
set undofile
set nobackup
set noswapfile

" tabs
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set shiftround

" general display settings
set number
set relativenumber
nnoremap <leader><space> :noh<cr>
set ruler
set cmdheight=2
set hlsearch
set showmode
set showcmd
set wildmenu
set showtabline=2

nnoremap j gj
nnoremap k gk
nnoremap <F8> :buffers<CR>:buffer<Space>

nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>l :set list!<CR>

" Toggle background (solarized colorscheme)
call togglebg#map("<F5>")

" Remap chaning focus of split windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

