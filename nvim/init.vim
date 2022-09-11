" -- setup vimplug if not set up -- 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins ---
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
call plug#end()

" --- Config ---
set rnu
filetype plugin on
set nohlsearch
set softtabstop=4 tabstop=4
set shiftwidth=4
set expandtab 
set signcolumn=yes
set autoindent
set smartindent

augroup shortenTabs
    au!
    au FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal tabstop=2
    au FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal shiftwidth=2
augroup END

" Color Scheme
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme xcodedark

augroup vim-colors-xcode
    autocmd!
augroup END

" italic comments
autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italicj

" apexcode filetype detection
au BufRead,BufNewFile *.cls,*.apex set filetype=apexcode

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua require('config')
lua require('treesitter')
lua require('lspconfig')
