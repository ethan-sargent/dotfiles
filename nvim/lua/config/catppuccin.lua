vim.cmd.colorscheme "catppuccin"

require("catppuccin").setup {
  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    lsp_saga = true,
    markdown = true,
    treesitter = true,
    treesitter_context = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
}
