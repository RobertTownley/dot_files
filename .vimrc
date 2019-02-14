set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'vim-syntastic/syntastic'
Plugin 'posva/vim-vue'
Plugin 'w0rp/ale'
Plugin 'nvie/vim-flake8'
Plugin 'flazz/vim-colorschemes'

" ...

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

" Highlight searches as they're typed
set incsearch " highlight characters as they're entered
set hlsearch " highlight matches
" map CTRL+L to unhighlighting the current search
nnoremap <silent> <C-l> :nohl<CR><C-l>

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

" When saving a python file, automatically call Flake8
autocmd BufWritePost *.py call Flake8()

" Only call ALELint manually
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 0

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
