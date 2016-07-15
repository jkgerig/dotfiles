"
" vimrc
"

" Use Vim instead of Vi settings
set nocompatible

" OS-specific path for .vim, vimfiles, etc.
if has ("win32")
    "windows uses $HOME/vimfiles
    let MYVIMFILES=expand("$HOME") . '/vimfiles'
else
    let MYVIMFILES=expand("$HOME") . '/.vim'
endif

" ==========================================================
" Use Vundle
filetype off    " required

" set runtime path to include Vundle and initialize
let &rtp = &rtp . ',' . MYVIMFILES . '/bundle/vundle'
call vundle#begin()
" alterate location for vundle to install plugins
"call vundle#begin('~/path/to/plugins')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.

" GitHub
" Plugin 'tpope/vim-fugitive'

" http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" List Plugins for Vundle here:
" ==========================================================



" ==========================================================

" Vundle help/info:
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
call vundle#end()
" end of Vundle setup
" ==========================================================

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Make backspace delete over anything
set backspace=indent,eol,start

" Color settings
" ==========================================================

syntax enable

set background=dark
"set background=light

"colorscheme jellybeans
colorscheme solarized
"colorscheme default
"colorscheme monokai

" ==========================================================
let &undodir = MYVIMFILES . '/undo//'
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

" Keep tabs consistent. See: http://vimcasts.org/episodes/tabs-and-spaces/
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

cd $HOME

" Toggle background (solarized colorscheme)
call togglebg#map("<F5>")

" Remap chaning focus of split windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

