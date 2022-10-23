" -- setup vimplug if not set up -- 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins -- 
lua require('impatient')
lua require('plugins')
filetype plugin indent on

" --- Config ---
set completeopt=menu,menuone,noselect
set rnu
set nu
set nohlsearch
set incsearch
set ts=2 sts=2 sw=2
set expandtab 
set signcolumn=yes
set autoindent
set smartindent
set undofile
set ignorecase
set smartcase
set termguicolors
set nowrap
set guitablabel=\[%N\]\ %t\ %M
set synmaxcol=500
set mouse=

nnoremap <SPACE> <Nop>
let mapleader=" "
tnoremap <Esc> <C-\><C-n>


" Apex filetype detection and sfdx key bindings
augroup sfdxApex
    au!
    au BufRead,BufNewFile *.cls,*.apex,*.trigger set filetype=apexcode
    au FileType apexcode nnoremap <leader>sd :w  <bar> !sfdx force:source:deploy --sourcepath %<Enter>
    au FileType apexcode nnoremap <leader>sr :!sfdx force:source:retrieve --sourcepath %<Enter>
    au FileType apexcode nnoremap <leader>sq :!sfdx force:data:soql:query  --soqlqueryfile % <Enter>
    au FileType apexcode nnoremap <leader>sae :!sfdx force:apex:execute --apexcodefile % <Enter>
    au FileType apexcode nnoremap <leader>st :!sfdx force:apex:test:run --tests %:t:r --synchronous<Enter>
    au FileType apexcode nnoremap <leader>so :!sfdx force:org:open<Enter>
augroup END



