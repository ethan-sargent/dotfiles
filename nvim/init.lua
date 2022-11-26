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
opt.gdefault      = true


vim.api.nvim_set_keymap("n", "<SPACE>", "", {});
g.mapleader = " "
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>" , {});

require('sfdx')
