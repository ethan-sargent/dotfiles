vim.filetype.add({
  extension = {
    cmp = function()
      -- Search for "aura" text in file
      -- if vim.fn.search("aura", "nw") == 1 then
      --     return "aura"
      -- end
      return "aura"
    end,
    design = "aura",
    auradoc = "aura",
    cls = "apex",
    apex = "apex",
    trigger = "apex",
    soql = "soql"
  },
})
