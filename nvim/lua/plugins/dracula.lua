local _M = {
  'Mofiqul/dracula.nvim',
}

_M.config = function ()
  local dracula = require("dracula")
  local colors = dracula.colors()
  local prompt = "#44475a"
  local preview = colors.menu
  local results = colors.menu

  dracula.setup({
    -- customize dracula color palette
    -- colors = {
    --   bg = "#282A36",
    --   fg = "#F8F8F2",
    --   selection = "#44475A",
    --   comment = "#6272A4",
    --   red = "#FF5555",
    --   orange = "#FFB86C",
    --   yellow = "#F1FA8C",
    --   green = "#50fa7b",
    --   purple = "#BD93F9",
    --   cyan = "#8BE9FD",
    --   pink = "#FF79C6",
    --   bright_red = "#FF6E6E",
    --   bright_green = "#69FF94",
    --   bright_yellow = "#FFFFA5",
    --   bright_blue = "#D6ACFF",
    --   bright_magenta = "#FF92DF",
    --   bright_cyan = "#A4FFFF",
    --   bright_white = "#FFFFFF",
    --   menu = "#21222C",
    --   visual = "#3E4452",
    --   gutter_fg = "#4B5263",
    --   nontext = "#3B4048",
    -- },
    -- show the '~' characters after the end of buffers
    -- show_end_of_buffer = true, -- default false
    -- use transparent background
    transparent_bg = true, -- default false
    -- set custom lualine background color
    lualine_bg_color = "#44475a", -- default nil
    -- set italic comment
    italic_comment = true, -- default false
    -- overrides the default highlights see `:h synIDattr`
    overrides = {
      -- Examples
      -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
      -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
      -- Nothing = {} -- clear highlight of Nothing
    TelescopeMatching = { fg = colors.cyan},
    TelescopeNormal = { fg = prompt },
    TelescopePreviewBorder = { bg = preview, fg = preview },
    TelescopePreviewNormal = { bg = preview },
    TelescopePreviewTitle = { bg = colors.pink, fg = preview },
    TelescopePromptBorder = { bg = prompt, fg = prompt },
    TelescopePromptNormal = { bg = prompt},
    TelescopePromptPrefix = { bg = prompt },
    TelescopePromptTitle = { bg = colors.red, fg = prompt },
    TelescopeResultsBorder = { bg = results, fg = results },
    TelescopeResultsNormal = { bg = results },
    TelescopeResultsTitle = { fg = results },
    -- The current item
    TelescopeSelection = { fg = colors.bright_magenta, bg = results },
    TelescopeSelectionCaret = { fg = colors.bright_magenta, bg = results },
    },
  })
  vim.cmd('colorscheme dracula')
end

return _M;
