local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.apexcode = {
  install_info = {
    url = "~/Projects/tree-sitter-sfapex/apexcode", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    -- branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype = "apexcode", -- if filetype does not match the parser name
}
parser_config.soql = {
  install_info = {
    url = "~/Projects/tree-sitter-sfapex/soql", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    -- branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = true, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype = "soql", -- if filetype does not match the parser name
}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    }
  }
}

