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


" apex specific functions
augroup sfdxApex
    au!
    au BufRead,BufNewFile *.cls,*.apex,*.trigger set filetype=apexcode
augroup END

" sfdx key bindings
nnoremap <leader>sd :w  <bar> !sfdx force:source:deploy --sourcepath %<Enter>
nnoremap <leader>sr :!sfdx force:source:retrieve --sourcepath %<Enter>
nnoremap <leader>sq :!sfdx force:data:soql:query  --soqlqueryfile % <Enter>
nnoremap <leader>sae :!sfdx force:apex:execute --apexcodefile % <Enter>
nnoremap <leader>st :!sfdx force:apex:test:run --tests %:t:r --synchronous<Enter>
nnoremap <leader>so :!sfdx force:org:open<Enter>


lua require('config._telescope')
lua require('config._treesitter')
lua require('config._mason')
lua require('config._cmp')
lua require('config._feline')
lua require('config._ts_autotags')
lua require('config._comment')
lua require('config._trouble')

" lua require('config._tundra')
lua require('config._tokyonight')
colorscheme tokyonight-night

