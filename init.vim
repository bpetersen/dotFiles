" set leader key to ','
let mapleader=","

call plug#begin('~/.vim/plugged')

Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'croaker/mustang-vim'
Plug 'mxw/vim-jsx'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
" Plug 'carlitux/deoplete-ternjs'
Plug 'pangloss/vim-javascript'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'facebook/vim-flow'
Plug 'lambdatoast/elm.vim'
Plug 'mileszs/ack.vim'

" use the silver searcher instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" but don't let vim-flow do any omnifunc completion
"let g:flow#omnifunc = 0
" I had the timeout set really high to accommodate ramda, but the UX is not
" great.  Still haven't figured out how to precompile tern's autocomplete file
" so that it can parse faster.
let g:tern_request_timeout = 10

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

call plug#end()

" For terminal vim
set t_Co=256

" Set the greatest colorscheme ever
colorscheme mustang

" Set syntax highlighting on
syntax on
 
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
map <C-h> <C-w>h
map <C-l> <C-w>l

" Set nerdtree toggling
map <C-n> :NERDTreeToggle<CR>

" Close the current buffer without closing the pane
map <C-c> :bp\|bd #<CR>

" set indenting
set expandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on
"set cindent

" Don't warn me when switching buffers that haven't been saved
set hidden

" don't require .jsx extension for jsx files
let g:jsx_ext_required = 0

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
noremap <Leader>tr :TernRename

" Use ag if installed (brew install the_silver_searcher)
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

map <Leader>fj !python -m json.tool<CR>

"folding settings
" fold between braces -
" `za` - toggles
" `zc` - closes
" `zo` - opens
" `zR` - open all
" `zM` - close all
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
