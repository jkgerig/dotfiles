"
" vimrc
"

" Use Vim instead of Vi settings
set nocompatible

" Make backspace delete over anything
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

colorscheme murphy
set background=dark

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Set location for swapfiles, undo, and backup
"if !isdirectory("$HOME/.vim/backup")
"    call mkdir("$HOME/.vim/backup", "p")
"endif

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

