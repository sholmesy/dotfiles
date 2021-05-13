call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nicwest/vim-camelsnek'
Plug 'nvie/vim-flake8'
Plug 'tell-k/vim-autopep8'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'chrisbra/csv.vim'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
call plug#end()

" Syntax
syntax enable
set nowrap
set foldmethod=syntax

" Indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

nnoremap x "_x
xnoremap x "_x

" Lang Specific
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html,htmldjango  setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
filetype plugin indent on

" Standard stuff
set backspace=indent,eol,start
set scrolloff=3
set showmode
set hidden
set encoding=utf-8
set noswapfile
let g:netrw_liststyle=3
filetype plugin on
let mapleader=" "
set t_Co=256
set wildmenu
set background=dark
colorscheme seashell
set mouse=a
"set colorcolumn=80
set laststatus=0
set noshowcmd
set cmdheight=1
set clipboard+=unnamedplus

" Search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

"split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

nnoremap <C-w> <C-W><C-K>
nnoremap <C-a> <C-W><C-H>
nnoremap <C-s> <C-W><C-j>
nnoremap <C-d> <C-W><C-L>

"bashrc loads
let $BASH_ENV = "~/.bash_aliases"

set rtp+=~/.fzf

nnoremap <C-e> :Explore<CR>
nnoremap <C-t> :e#<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-]> :call jedi#goto()<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-v> :vs<CR>

set tags=./tags;
set undofile
set undodir=~/.vim/undodir

command! Behave execute "norm! yypV:Snek\<CR>Idef \<ESC>A(context):"
autocmd BufWritePost *.py call flake8#Flake8()

set showmode

if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END
endif

let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
