call plug#begin('~/.vim/plugged')

Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'croaker/mustang-vim'
Plug 'ternjs/tern_for_vim'
Plug 'mxw/vim-jsx'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'} " --tern-completer' }  | Plug 'ternjs/tern_for_vim'


call plug#end()

" For terminal vim
set t_Co=256

" Set the greatest colorscheme ever
colorscheme mustang

" Set syntax highlighting on
syntax on

" set leader key to ','
let mapleader=","
 
" Turn on the ruler to give row and column info
set ruler

" Turn on line numbers
set nu

" No backup files or swap files
set nobackup
set nowritebackup
set noswapfile


" Map control+j cntr+k etc to moving around in the vim windows
map <C-j> <C-w>j
map <C-k> <C-w>k
" this is actually a map for <C-h> but in most terminals control + h actually
" sends backspace 
map <BS> <C-w>h
map <C-l> <C-w>l

" Set nerdtree toggling
map <C-n> :NERDTreeToggle<CR>

" set indenting
set expandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on
"set cindent

" Don't warn me when switching buffers that haven't been saved
set hidden
" don't require .jsx extension for jsx files
let g:jx_ext_required = 0

" you complete me debugging
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'

" add linting information for javascript files using neomake instead of
" syntastic
let g:neomake_javascript_enabled_makers = ['eslint']

" When loading a buffer or saving a buffer, run Neomake (lint, etc.)
autocmd! BufWritePost,BufEnter * Neomake

let g:tern_show_argument_hints="on_hold"
let g:tern_map_keys=1
let g:tern_show_signature_in_pum =1

noremap <Leader>td :TernDoc
noremap <Leader>tt :TernType
