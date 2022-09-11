require('lspconfig').apex_ls.setup {
    cmd = { '/home/ethandev/dev/apex_lsp/apex-jorje-lsp', 
    '-Ddebug.internal.errors=true',
    '-Ddebug.semantic.errors=false', 
    '-Ddebug.completion.statistics=false',
    '-Dlwc.typegeneration.disabled=true',
    'apex.jorje.lsp.ApexLanguageServerLauncher' }
}

require('lspconfig').clangd.setup {}

