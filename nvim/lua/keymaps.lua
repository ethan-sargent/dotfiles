
local noremap = {noremap = true}
-- launch Lazy plugin manager window
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", noremap);


-- Terminal mode keybinds
-- remap escaping from terminal to something more convenient
vim.api.nvim_set_keymap("t", "<localleader><Esc>", "<C-\\><C-n>" , noremap);
-- Enable buffer navigation out from terminal buffers
vim.api.nvim_set_keymap("t", "<C-w>k", "<cmd>wincmd k<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w>j", "<cmd>wincmd j<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w>l", "<cmd>wincmd l<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w>h", "<cmd>wincmd h<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w><C-k>", "<cmd>wincmd k<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w><C-j>", "<cmd>wincmd j<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w><C-l>", "<cmd>wincmd l<CR>", noremap);
vim.api.nvim_set_keymap("t", "<C-w><C-h>", "<cmd>wincmd h<CR>", noremap);
