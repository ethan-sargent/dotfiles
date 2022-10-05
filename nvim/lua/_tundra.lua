require('nvim-tundra').setup({
  transparent_background = false,
  editor = {
    search = {},
    substitute = {},
  },
  syntax = {
    booleans = { bold = true, italic = true },
    comments = { bold = true, italic = true },
    conditionals = { bold = true },
    constants = { bold = true },
    functions = {},
    keywords = { bold = true },
    loops = { bold = true },
    numbers = { bold = true },
    operators = { bold = true },
    punctuation = {},
    strings = {},
    types = { bold = true },
  },
  diagnostics = {
    errors = {},
    warnings = {},
    information = {},
    hints = {},
  },
  plugins = {
    lsp = true,
    treesitter = true,
    cmp = true,
    telescope = true,
    -- context = true,
    -- dbui = true,
    -- gitsigns = true,
  },
  overwrite = {
    colors = {},
    highlights = {},
  },
})

vim.opt.background = 'dark'
vim.cmd('colorscheme tundra')
