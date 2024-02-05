local _M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
}

_M.config = function()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "apex", "apexcode", "apexanon", "xml" },
      }),
      -- null_ls.builtins.diagnostics.pmd.with({
      --   args = {
      --     "--format", "json",
      --     "--dir", "force-app",
      --     "--rulesets", "pmd/apex_rules.xml",
      --     "--cache", ".pmdCache",
      --     "--minimum-priority", "3",
      --     "-t", "0"
      --   },
      --   filetypes = { "apex", "apexcode", "apexanon", "xml" }
      -- }),
    },
  })
end

return _M
