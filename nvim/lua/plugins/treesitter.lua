local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
  },
  event = "BufReadPost",
}

M.config = function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  -- Apex and SOQL parsers
  parser_config.apex = {
    install_info = {
      url = "~/Projects/tree-sitter-sfapex/apex", -- local path or git repo
      files = { "src/parser.c" },
      -- optional entries:
      -- branch = "main", -- default branch in case of git repo if different from master
      generate_requires_npm = true,       -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
    },
    filetype = "apexcode",                -- if filetype does not match the parser name
  }
  parser_config.soql = {
    install_info = {
      url = "~/Projects/tree-sitter-sfapex/soql", -- local path or git repo
      files = { "src/parser.c" },
      -- optional entries:
      -- branch = "main", -- default branch in case of git repo if different from master
      generate_requires_npm = true,       -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
    },
    filetype = "soql",                    -- if filetype does not match the parser name
  }


  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "html" },
    },
    indent = {
      disable = { "javascript", "ecma", "jsx", "tsx" }, -- necessary due to open treesitter indentation bug with JSDoc/TSDoc
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    endwise = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,     -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = true, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  })

  require("treesitter-context").setup({
    enable = true,
    max_lines = 0,       -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = {
                         -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        "class",
        "function",
        "method",
        "for",
        "while",
        "if",
        "switch",
        "case",
        "interface",
        "struct",
        "enum",
      },
      -- Patterns for specific filetypes
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      tex = {
        "chapter",
        "section",
        "subsection",
        "subsubsection",
      },
      haskell = {
        "adt",
      },
      rust = {
        "impl_item",
      },
      terraform = {
        "block",
        "object_elem",
        "attribute",
      },
      scala = {
        "object_definition",
      },
      vhdl = {
        "process_statement",
        "architecture_body",
        "entity_declaration",
      },
      markdown = {
        "section",
      },
      elixir = {
        "anonymous_function",
        "arguments",
        "block",
        "do_block",
        "list",
        "map",
        "tuple",
        "quoted_content",
      },
      json = {
        "pair",
      },
      typescript = {
        "export_statement",
      },
      yaml = {
        "block_mapping_pair",
      },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },
    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20,   -- The Z-index of the context window
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
  })
end

return M
