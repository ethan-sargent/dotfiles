local opt = vim.opt
local g = vim.g

-- Plugins
require('impatient')
require('plugins')


opt.completeopt   = "menu,menuone,noselect"
opt.rnu           = true
opt.nu            = true
opt.hlsearch      = false
opt.incsearch     = true
opt.ts            = 2
opt.sts           = 2
opt.sw            = 2
opt.expandtab     = true
opt.signcolumn    = "yes"
opt.autoindent    = true
opt.smartindent   = true
opt.undofile      = true
opt.ignorecase    = true
opt.smartcase     = true
opt.termguicolors = true
opt.wrap          = false
opt.guitablabel   = "[%N] %t %M"
opt.synmaxcol     = 500
opt.mouse         = ""

-- TODO: update this to use native lua commands
vim.cmd([[
nnoremap <SPACE> <Nop>
let mapleader=" "
tnoremap <Esc> <C-\><C-n>
augroup sfdxApex
    au!
    au BufRead,BufNewFile *.cls,*.apex,*.trigger,*.soql set filetype=apexcode
augroup END

    nnoremap <leader>sd :w  <bar> !sfdx force:source:deploy --sourcepath %<Enter>
    nnoremap <leader>sr :!sfdx force:source:retrieve --sourcepath %<Enter>
    nnoremap <leader>sq :!sfdx force:data:soql:query  --soqlqueryfile % <Enter>
    nnoremap <leader>sae :!sfdx force:apex:execute --apexcodefile % <Enter>
    nnoremap <leader>st :!sfdx force:apex:test:run --tests %:t:r --synchronous<Enter>
    nnoremap <leader>so :!sfdx force:org:open<Enter>
]])
