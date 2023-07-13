
vim.api.nvim_set_keymap("n", "<Space>", "", {}); -- set to noop before mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.loader.enable()

require('keymaps')
require('settings')
require('config.lazy')
require('config.sfdx')

