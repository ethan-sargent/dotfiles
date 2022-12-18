local g = vim.g;
local opt = vim.opt;

vim.api.nvim_set_keymap("n", "<Space>", "", {});
g.mapleader = " "
g.maplocalleader = "\\"

-- Plugins
require('impatient')
require('plugins')
require('sfdx')

opt.completeopt   = "menu,menuone,noselect"
opt.rnu           = true
opt.nu            = true
opt.hlsearch      = false
opt.incsearch     = true
opt.ts            = 2
opt.sts           = 2
opt.sw            = 2
opt.expandtab     = true
opt.smarttab      = true
opt.shiftround    = true
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
opt.scrolloff     = 1
opt.sidescrolloff = 5
opt.lazyredraw    = true
opt.cursorline    = true

-- opt.foldmethod    = "indent"
-- opt.foldnestmax   = 3

-- Terminal mode keybinds
vim.api.nvim_set_keymap("t", "<localleader><Esc>", "<C-\\><C-n>" , {noremap = true});

