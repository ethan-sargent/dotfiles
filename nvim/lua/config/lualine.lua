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


require('lualine').setup {
  options = {
    theme = 'catppuccin',
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
