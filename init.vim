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
Plug 'reasonml-editor/vim-reason'
Plug 'sbdchd/neoformat'
" Plug 'derekwyatt/vim-scala'

" use the silver searcher instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" but don't let vim-flow do any omnifunc completion
let g:flow#omnifunc = 0
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

" Prettier
" on save: autocmd BufWritePre *.js :normal gggqG
" autocmd FileType javascript.jsx,javascript setlocal formatprg=prettier\ --stdin
" prettier-standard (no semicolons)
" autocmd FileType javascript set formatprg=prettier-standard
"

" ReasonML
" Always wrap at 90 columns
let g:vimreason_extra_args_expr_reason = '"--print-width 90"'

" Wrap at the window width
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "winwidth('.')"

" Wrap at the window width but not if it exceeds 120 characters.
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "min([120, winwidth('.')])"

" command + shift + m => pretty print
autocmd FileType reason map <buffer> <D-M> :ReasonPrettyPrint<Cr>

let g:neomake_reason_enabled_makers = ['merlin']

"neoformat
"Format on save.  undojoin combines the last keystroke with the formatting so
"you're not battling autoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_javascript_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--config ~/.config/prettier/config.yml'],
  \ 'stdin': 1,
  \ }
let g:neoformat_scala_scalafmt = {
  \ 'exe': 'scalafmt',
  \ 'args': ['--stdin'],
  \ 'stdin': 1,
  \ }

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

