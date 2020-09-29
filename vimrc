set nocompatible
set encoding=utf-8

" Leader
let mapleader = " "

set backspace=2
set nobackup
set nowritebackup
set noswapfile

set history=50
set ruler

set modelines=0
set nomodeline

set number
set numberwidth=5

set textwidth=80
set colorcolumn=+1

set nojoinspaces

set tabstop=2
set shiftwidth=2

set nospell

syntax on
filetype on
filetype plugin indent on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

colorscheme dracula

" force use h/j/k/l
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

