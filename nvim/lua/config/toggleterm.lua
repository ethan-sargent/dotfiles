require("toggleterm").setup({

})


vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {noremap = true});
-- vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm<CR>", {});
vim.api.nvim_set_keymap("t", "<leader>tt", "<cmd>ToggleTerm<CR>" , {noremap = true});
