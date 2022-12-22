vim.filetype.add({
  extension = {
    cmp = "aura",
    design = "aura",
    auradoc = "aura",
    cls = "apex",
    apex = "apex",
    trigger = "apex",
    soql = "soql"
  },
  filename = {
    ["justfile"] = 'just'
  },
  pattern = {
    ['${XDG_CONFIG_HOME}/git/config'] = 'gitconfig',
  }

})
