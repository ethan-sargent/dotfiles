" -- setup vimplug if not set up -- 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins -- im
call plug#begin("~/.vim/plugged")
Plug 'arzg/vim-colors-xcode'
Plug 'ryanoasis/vim-devicons'
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
call plug#end()
set completeopt=menu,menuone,noselect

" --- Config ---
set rnu
set nu
filetype plugin on
set nohlsearch
set incsearch
set softtabstop=4 tabstop=4
set shiftwidth=4
set expandtab 
set signcolumn=yes
set autoindent
set smartindent
set background=dark

nnoremap <SPACE> <Nop>
let mapleader=" "

augroup shortenTabs
    au!
    au FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal tabstop=2
    au FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal shiftwidth=2
augroup END

" Color Scheme
if (has("termguicolors"))
    set termguicolors
endif
colorscheme tundra 
" colorscheme xcodedark

augroup vim-colors-xcode
    autocmd!
    " italic comments
    au ColorScheme * hi Comment        cterm=italic gui=italic
    au ColorScheme * hi SpecialComment cterm=italic gui=italic
augroup END


" apex specific functions
augroup sfdxApex
    au!
    au BufRead,BufNewFile *.cls,*.apex,*.trigger set filetype=apexcode
    au FileType apexcode nnoremap <buffer> <leader>wo :!sfdx force:source:deploy --sourcepath %<Enter>
augroup END
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require('_telescope')
lua require('_treesitter')
lua require('_cmp')
