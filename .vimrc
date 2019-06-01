set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
" Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'prettier/vim-prettier'
Plugin 'mxw/vim-jsx'
Plugin 'w0rp/ale'
Plugin 'flazz/vim-colorschemes'
Plugin 'mattn/emmet-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Display
colorscheme badwolf

" Enable system-wide copy/paste
set clipboard=unnamed

" Highlight the current line
set cursorline

" Break lines longer than 120 character
set textwidth=120

" Show line numbers
set number

" Show the currently-typed command
set showcmd

" Ale
let g:airline#extensions#ale#enabled = 1

" Emmet
let g:user_emmet_leader_key='<Tab>'

" Highlight searches as they're typed
set incsearch " highlight characters as they're entered
set hlsearch " highlight matches
" map CTRL+L to unhighlighting the current search
nnoremap <silent> <C-l> :nohl<CR><C-l>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Default filetypes
set tabstop=2 |
set softtabstop=2 |
set shiftwidth=2
set expandtab

" Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=119 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Javascript
au BufNewFile,BufRead *.js
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" HTML
au BufNewFile,BufRead *.html
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab
