call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'wellle/targets.vim'
Plug 'kopischke/vim-fetch'
Plug 'flazz/vim-colorschemes'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'francoiscabrol/ranger.vim'
call plug#end()

" Syntax
syntax enable
set nowrap

" Indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


nnoremap x "_x
xnoremap x "_x

" Lang Specific
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype html,htmldjango  setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype jade setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd Filetype objc setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd Filetype less setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
filetype plugin indent on

" Go vim plugin stuff
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" Snippet stuff
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Standard stuff
set backspace=indent,eol,start
set scrolloff=3
set showmode
set hidden
set encoding=utf-8
set noswapfile
let g:netrw_liststyle=3
set clipboard=unnamed
filetype plugin on
let mapleader=" "
let &t_Co=256
set t_Co=256
set wildmenu
set background=dark
colorscheme seashell

" Search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
"set hlsearch

"split navigations
"Ctrl-j move to the split below
"Ctrl-k move to the split above
"Ctrl-l move to the split to the right
"Ctrl-h move to the split to the left
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>
set mouse=a

"ALE
let g:ale_completion_enabled = 1

"bashrc loads
let $BASH_ENV = "~/.bash_aliases"

set rtp+=~/.fzf

nnoremap <Leader>s :e# <CR>
nnoremap <Leader>/ :Ag <CR>
nnoremap <Leader>dbf :!pgfes <CR>
nnoremap <Leader>dbi :!pgint <CR>

nnoremap <Leader>p <F2> <CR>
set tags=~/Work/development/festicket/festicket/apps/tags
