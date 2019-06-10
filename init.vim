" set leader key to ','
let mapleader=","

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'croaker/mustang-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

call plug#end()

" Use ag if installed (brew install the_silver_searcher)
if executable('ag')
  let g:ackprg = 'ag --vimgrep' " use the silver searcher instead of ack
  " Note we extract the column as well as the file and line number
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

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

" Use tab and shift+tab to cycle through buffers
map <Tab> :bnext<CR>:redraw<CR>:ls<CR>
map <S-Tab> :bprevious<CR>:redraw<CR>:ls<CR>

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

"neoformat
"Format on save.  undojoin combines the last keystroke with the formatting so
"you're not battling autoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_javascript_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--stdin-filepath', '"%:p"', '--config ~/.config/prettier/config.yml'],
  \ 'stdin': 1,
  \ }
