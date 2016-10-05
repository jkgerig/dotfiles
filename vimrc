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

colorscheme solarized

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
set wildignorecase
set showtabline=2
set hidden

" Toggle background (solarized colorscheme)
call togglebg#map("<F5>")

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

nmap <leader><Tab> :set expandtab!<CR>:set expandtab?<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>l :set list!<CR>
nmap <leader>b :buffers<CR>:buffer<Space>

set timeout timeoutlen=1500 ttimeoutlen=100

" vim-tmux-navigator settings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

nnoremap <silent> h :tabprevious<CR>
nnoremap <silent> l :tabnext<CR>
nnoremap <silent> j :bn<CR>
nnoremap <silent> k :bp<CR>

" splits
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sj :rightbelow new<CR>

" vimwiki settings
let g:vimwiki_global_ext = 0

let wiki_1 = {}
let wiki_1.path = '~/Dropbox/vimwiki/'
let wiki_1.index = 'index'

let g:vimwiki_list = [wiki_1]

"Syntax highlighting under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"Align GFM tables
au FileType markdown vmap <leader><bslash> :EasyAlign*<BAR><CR>

"augroup pencil
"    autocmd!
"    autocmd FileType markdown,mkd call pencil#init()
"    autocmd FileType text         call pencil#init()
"augroup END

" Color for limelight background dimming
let g:limelight_conceal_ctermfg = '240'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

nmap <leader>gg :Goyo<CR>

nmap <silent> <leader>bd :bp\|bd #<CR>
