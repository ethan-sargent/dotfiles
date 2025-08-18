local _M = {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        gemma_ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "Ollama (Gemma 12b Default)",
            schema = {
              model = {
                default = "gemma3:12b-it-qat"
              }
            }
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemma_ollama",
        },
        inline = {
          adapter = "gemma_ollama",
        },
        cmd = {
          adapter = "gemma_ollama",
        },
      },
    });
    vim.keymap.set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<Leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end
}



return _M;
