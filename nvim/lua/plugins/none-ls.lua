local _M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  event = "BufReadPre",
}

_M.config = function()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "apex", "apexcode", "apexanon", "xml" },
      }),
      null_ls.builtins.diagnostics.pmd.with({
        args = {
          "check",
          vim.api.nvim_buf_get_name(0),
          "--format", "json",
          "--rulesets", "config/pmd/apex_rules.xml",
          "--cache", ".pmdCache",
          "--minimum-priority", "3",
          "-t", "0",
          "--no-progress"
        },
        filetypes = { "apex", "apexcode", "apexanon", "xml" }
      }),
      -- none-ls-extras
      require("none-ls.diagnostics.eslint_d"),
      require("none-ls.code_actions.eslint_d"),
    },
  })
end

return _M
