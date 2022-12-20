-- loads mason + mason lspconfig first to autolink mason installed lsp servers to cmp
require('config.mason')
-- install vs code snippets into luasnip
require("luasnip.loaders.from_vscode").lazy_load()
-- Set up nvim-cmp.cmp
local lspkind = require('lspkind');

local cmp = require 'cmp'

cmp.setup {
  enabled = true,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
      -- { name = 'buffer' }, -- removing buffer suggestions
    }),
  formatting = {
    fields = { "abbr", "menu", "kind" },
    format = function (entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
      })(entry, vim_item);
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.abbr = kind.abbr
      kind.kind = strings[1]
      kind.menu = "   " .. strings[2]
      return kind
    end
  }
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
      -- { name = 'buffer' },
    })
})
cmp.setup.filetype('norg', {
  sources = cmp.config.sources({
    { name = "neorg"},
    { name = "buffer"},
  })
})


cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})


cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})


-- LSPCONFIG
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>F', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  debounce_text_changes = 100,
}
require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags
}
require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}
-- require('lspconfig').apex_ls.setup {
--     cmd = { '/path/to/native/image/apex-jorje-lsp',
--     '-Ddebug.internal.errors=true',
--     '-Ddebug.semantic.errors=false',
--     '-Ddebug.completion.statistics=false',
--     '-Dlwc.typegeneration.disabled=true',
--     'apex.jorje.lsp.ApexLanguageServerLauncher' },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
require 'lspconfig'.apex_ls.setup {
  apex_jar_path = '/Users/ethan.sargent/languageservers/apex/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
  apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "apexcode", "apex", "apexanon" }
}

vim.g.completion_enable_snippet = 'luasnip'
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require 'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      semantic = {
        enable = false  --[[ disable semantic highlights  ]]
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require 'lspconfig'.gopls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
require 'lspconfig'.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
