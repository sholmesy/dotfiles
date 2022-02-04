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
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'davidhalter/jedi'
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

" Lang Specific
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html,htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype tf setlocal ts=2 sts=2 sw=2
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
colorscheme gruvbox
set mouse=
" set colorcolumn=80
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

" bashrc loads
let $BASH_ENV = "~/.bash_aliases"
set rtp+=~/.fzf

" Remapped bindings
nnoremap <C-e> :Explore<CR>
nnoremap <C-t> :e#<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-]> :call jedi#goto()<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-n> :tabn<CR>
nnoremap <C-p> :tabp<CR>

" Undofile & tags
set tags=./tags;
set undofile
set undodir=~/.vim/undodir
set showmode

command! Behave execute "norm! yypV:Snek\<CR>Idef \<ESC>A(context):"

" Jedi config
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let local_python_env = system('echo -n venv.`basename $PWD`')
autocmd VimEnter *.py let g:jedi#environment_path = local_python_env

" Custom event handlers
autocmd BufWritePost *.py call flake8#Flake8()
autocmd BufReadPost,FileReadPost,BufNewFile,FocusGained * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window bash")

" Windows specific system clipboard syncing
if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END
endif
