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

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.apexcode = "java" -- the someft filetype will use the python parser and queries.
