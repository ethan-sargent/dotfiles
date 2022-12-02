require("toggleterm").setup({
  shading_factor = '3'
})


vim.api.nvim_set_keymap("n", "<localleader>t", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true});
vim.api.nvim_set_keymap("n", "<localleader>f", "<cmd>ToggleTerm direction=float<CR>", {});
vim.api.nvim_set_keymap("t", "<localleader>t", "<cmd>ToggleTerm<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<localleader>f", "<cmd>ToggleTerm<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w>k", "<cmd>wincmd k<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w>j", "<cmd>wincmd j<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w>l", "<cmd>wincmd l<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w>h", "<cmd>wincmd h<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w><C-k>", "<cmd>wincmd k<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w><C-j>", "<cmd>wincmd j<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w><C-l>", "<cmd>wincmd l<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<C-w><C-h>", "<cmd>wincmd h<CR>", {noremap = true});
