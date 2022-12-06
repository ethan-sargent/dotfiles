require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
        }
      }
    },
    ["core.norg.concealer"] = {},
    ['core.gtd.base'] = {
      config = {
        workspace = "work"
      }
    },
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
    ['core.integrations.nvim-cmp'] = {}
  }
}
