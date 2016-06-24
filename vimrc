"
" vimrc
"

" Use Vim instead of Vi settings
set nocompatible

" Make backspace delete over anything
set backspace=indent,eol,start

" I actually prefer the 8-color colorscheme over the 256...
set background=light
set t_Co=8

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Set location for swapfiles, undo, and backup
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//
set undodir=~/.vim/backup//

" tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" general display settings
set number
"set relativenumber
nnoremap <leader><space> :noh<cr>
set ruler
set cmdheight=2
set hlsearch
set showmode
set showcmd
"set cursorline
set wildmenu
set showtabline=2

nnoremap j gj
nnoremap k gk

