
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", {noremap = true});


-- Terminal mode keybinds
vim.api.nvim_set_keymap("t", "<localleader><Esc>", "<C-\\><C-n>" , {noremap = true});
