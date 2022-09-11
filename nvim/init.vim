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
call plug#end()

" --- Config ---
set rnu
filetype plugin indent on


" tab configuration 
set softtabstop=4
set shiftwidth=4
set expandtab 
" autocmd FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal tabstop=2
" autocmd FileType css,json,*.js,*.jsx,*.ts,*.tsx,*.html,*.htm setlocal shiftwidth=2

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
set nohlsearch

lua require('config')

