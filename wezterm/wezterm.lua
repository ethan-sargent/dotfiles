local wezterm = require('wezterm');
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = ''

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = ''
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#2E3440'
    local background = '#434c5e'
    local foreground = '#ECEFF4'

    if tab.is_active then
      background = '#5E81AC'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b4252'
      foreground = '#909090'
    end

    local edge_foreground = background

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    local title =  tab.tab_index .. ': ' ..wezterm.truncate_right(tab.active_pane.title, max_width - 4)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)
return {
  color_scheme = "Nord (base16)",

  font_size = 15,
  font = wezterm.font_with_fallback({
    -- 'Iosevka',
    'Iosevka SS04'
  }),

  tab_bar_at_bottom = true,
  show_new_tab_button_in_tab_bar = false,
  colors = {
    tab_bar = {
      -- The color of the inactive tab bar edge/divider
      inactive_tab_edge = '#2E3440',
    },
  },
  window_frame = {
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    font = wezterm.font { family = 'Iosevka SS04', weight = 'Bold' },

    -- The size of the font in the tab bar. Default to 10.0 on Windows but 12.0 on other systems
    font_size = 12.0,

    -- The overall background color of the tab bar when the window is focused
    active_titlebar_bg = '#2E3440',

    -- The overall background color of the tab bar when the window is not focused
    inactive_titlebar_bg = '#2E3440',
  },

  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 800 },
  keys = {
    { key = 'b', mods = 'LEADER|CTRL',  action = wezterm.action.SendString('\x02'), },
    { key = "%", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '|', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = "-", mods = "LEADER",       action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "v", mods = "LEADER",       action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "s", mods = "LEADER",       action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "\\",mods = "LEADER",       action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "+", mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "c", mods = "LEADER",       action = wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "h", mods = "LEADER",       action = wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",       action = wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",       action = wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",       action = wezterm.action{ActivatePaneDirection="Right"}},
    { key = "h", mods = "LEADER|CTRL",  action = wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER|CTRL",  action = wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER|CTRL",  action = wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER|CTRL",  action = wezterm.action{ActivatePaneDirection="Right"}},
    { key = "H", mods = "LEADER|SHIFT", action = wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action = wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action = wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action = wezterm.action{AdjustPaneSize={"Right", 5}}},
    { key = "1", mods = "LEADER",       action = wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action = wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action = wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action = wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action = wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action = wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action = wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action = wezterm.action{ActivateTab=7}},
    { key = "9", mods = "LEADER",       action = wezterm.action{ActivateTab=8}},
    { key = "&", mods = "LEADER|SHIFT", action = wezterm.action{CloseCurrentTab={confirm=true}}},
    { key = "x", mods = "LEADER",       action = wezterm.action{CloseCurrentPane={confirm=true}}},
  }
}
