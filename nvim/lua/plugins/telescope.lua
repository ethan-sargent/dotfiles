local _M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    init = function()
      require("setup.telescope")
    end,
    config = function()
      require('config.plugins.telescope')
    end,
    cmd = 'Telescope',
    keys = '<leader>f'
}

_M.init = function ()
  local project_files = function()
    local opts = {} -- define here if you want to define something
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
      require"telescope.builtin".git_files(opts)
    else
      require"telescope.builtin".find_files(opts)
    end
  end

  local opts = { noremap = true, silent = true };
  vim.keymap.set('n', '<leader>ff', project_files, opts)
  vim.keymap.set('n', '<leader>fg', function() require("telescope.builtin").live_grep() end, opts)
  vim.keymap.set('n', '<leader>fb', function() require("telescope.builtin").buffers() end, opts)
  vim.keymap.set('n', '<leader>fh', function() require("telescope.builtin").help_tags() end, opts)
  vim.keymap.set('n', '<leader>fr', function() require("telescope.builtin").oldfiles() end, opts)
end

_M.config = function ()
  local telescope = require("telescope");
  local actions = require("telescope.actions");

  telescope.setup {
    defaults = {
      border = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim" -- removes leading ./
      },
      entry_prefix = "  ",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<Tab>"] = actions.move_selection_worse,
          ["<S-Tab>"] = actions.move_selection_better,
        },
        n = {
          ["<Tab>"] = actions.move_selection_worse,
          ["<S-Tab>"] = actions.move_selection_better,
        }
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
      },
    },
  }
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')


end

return _M;
