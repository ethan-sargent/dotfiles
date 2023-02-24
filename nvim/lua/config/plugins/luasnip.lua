local luasnip = require("luasnip")

luasnip.config.setup({
  history = true,
  enable_autosnippets = false,
  -- Update more often, :h events for more info.
  -- updateevents = "TextChanged,TextChangedI",
})

vim.cmd([[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]])
require("luasnip.loaders.from_vscode").lazy_load({
  path = 'snippets',
  exclude = { "global", "all"}
})
