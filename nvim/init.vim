" -- setup vimplug if not set up -- 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins -- im
call plug#begin("~/.vim/plugged")
Plug 'arzg/vim-colors-xcode'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'windwp/nvim-autopairs'
Plug 'mechatroner/rainbow_csv'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'sam4llis/nvim-tundra'
Plug 'tpope/vim-vinegar'
Plug 'feline-nvim/feline.nvim'
Plug 'windwp/nvim-ts-autotag'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'numToStr/Comment.nvim'
call plug#end()
set completeopt=menu,menuone,noselect

" --- Config ---
set rnu
set nu
" filetype plugin on
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
nnoremap <leader>sq :w  <bar> !sfdx force:data:soql:query  --soqlqueryfile % <Enter>
nnoremap <leader>sae :w <bar> !sfdx force:apex:execute --apexcodefile % <Enter>
nnoremap <leader>st :!sfdx force:apex:test:run --tests %:t:r --synchronous<Enter>
nnoremap <leader>so :!sfdx force:org:open<Enter>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require('_telescope')
lua require('_treesitter')
lua require('_mason')
lua require('_cmp')
lua require('_tundra')
lua require('_feline')
lua require('_ts_autotags')
lua require('_comment')
