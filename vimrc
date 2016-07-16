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

execute pathogen#infect()
call pathogen#helptags()

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

