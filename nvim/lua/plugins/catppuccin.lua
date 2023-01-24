local _M = {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  priority = 1000
}

_M.config = function()

  vim.cmd.colorscheme "catppuccin"

  require("catppuccin").setup {
    flavour = "mocha",
    integrations = {
      cmp = true,
      gitsigns = true,
      telescope = true,
      lsp_saga = true,
      mason = true,
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
end
return _M;
