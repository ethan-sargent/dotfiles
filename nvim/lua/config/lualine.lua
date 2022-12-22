-- sfdx get org
local function read_file(path)
  local file = io.open(path, "r") -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read("*a") -- *a or *all reads the whole file
  file:close()
  return content
end

local function sfdx_current_org()
  local sfConfigFile = read_file(".sfdx/sfdx-config.json");
  if not sfConfigFile then return '' end
  local parsedConfig = vim.json.decode(sfConfigFile);
  return '' .. parsedConfig["defaultusername"]
end
local colors = require("monokai-pro.themes.monokai-spectrum")

local monokai_pro = {}

monokai_pro.normal = {
	a = { bg = colors.base.yellow, fg = colors.base.black, gui = "bold" },
	b = { bg = colors.editorSuggestWidget.background, fg = colors.base.yellow },
	c = { bg = colors.base.black, fg = colors.base.black },
	x = { bg = colors.base.black, fg = colors.base.suggestWidgetForeground },
}

monokai_pro.insert = {
	a = { bg = colors.base.green, fg = colors.base.black },
	b = { bg = colors.editorSuggestWidget.background, fg = colors.base.green },
}

monokai_pro.command = {
	a = { bg = colors.base.yellow, fg = colors.base.black },
	b = { bg = colors.editorSuggestWidget.background, fg = colors.base.yellow },
}

monokai_pro.visual = {
	a = { bg = colors.base.magenta, fg = colors.base.black },
	b = { bg = colors.editorSuggestWidget.background, fg = colors.base.magenta },
}

monokai_pro.replace = {
	a = { bg = colors.base.red, fg = colors.base.black },
	b = { bg = colors.editorSuggestWidget.background, fg = colors.base.red },
}

monokai_pro.inactive = {
	a = { bg = colors.base.black, fg = colors.base.yellow },
	b = { bg = colors.base.black, fg = colors.base.black },
	c = { bg = colors.base.black, fg = colors.base.black },
}




require('lualine').setup {
  options = {
    theme = monokai_pro,
    component_separators = '⏽',
    section_separators = { left = '', right = '' },
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      { 'mode',
        -- separator = { left = '' },
        right_padding = 0
      },
    },
    lualine_b = {
      'filename',
      { 'branch',
        icon = ''
      },
      {
        sfdx_current_org,
        }
      },
      lualine_c = {
        'fileformat',
      },
      lualine_x = {},
      lualine_y = {
        {
          'filetype',
        },
        'progress'
      },
      lualine_z = {
        { 'location',
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
