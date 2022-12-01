require("toggleterm").setup({
  shading_factor = '3'
})


vim.api.nvim_set_keymap("n", "<localleader>t", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true});
vim.api.nvim_set_keymap("n", "<localleader>f", "<cmd>ToggleTerm direction=float<CR>", {});
vim.api.nvim_set_keymap("t", "<localleader>t", "<cmd>ToggleTerm<CR>", {noremap = true});
vim.api.nvim_set_keymap("t", "<localleader>f", "<cmd>ToggleTerm<CR>", {noremap = true});
