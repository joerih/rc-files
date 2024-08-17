local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()

-- Behavior
config.window_close_confirmation = 'NeverPrompt'
config.native_macos_fullscreen_mode = true
config.pane_focus_follows_mouse = true
config.check_for_updates = false
config.quick_select_patterns = {
  'git push --set-upstream .*$',
}

-- Appearance
config.initial_rows = 40
config.initial_cols = 160
config.font = wezterm.font 'Iosevka Term'
config.font_size = 16
config.default_cursor_style = 'SteadyBar'
config.cursor_thickness = 2
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 18
config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
config.inactive_pane_hsb = { saturation = 1.0, brightness = 0.5 }

-- Colors
local default_text = "#B2B2B2"
local default_background = "#000000"
local black = '#2E3436'
local red = '#CC0000'
local green = '#4E9A06'
local yellow = '#C4A000'
local blue = '#3465A4'
local magenta = '#75507B'
local cyan = '#06989A'
local white = '#D3D7CF'
local bright_black = '#555753'
local bright_red = '#EF2929'
local bright_green = '#8AE234'
local bright_yellow = '#FCE94F'
local bright_blue = '#729FCF'
local bright_magenta = '#AD7FA8'
local bright_cyan = '#34E2E2'
local bright_white = '#EEEEEC'

config.colors = {
  cursor_bg = yellow,
  cursor_border = yellow,
  split = black,
  selection_fg = black,
  selection_bg = yellow,
  quick_select_label_bg = { Color = yellow },
  quick_select_label_fg = { Color = black },

  tab_bar = {
    background = black,
    inactive_tab_hover = {
      -- The color fields are not used because use_fancy_tab_bar is set to false, but they are required.
      bg_color = '#000000',
      fg_color = '#000000',
      italic = false,
    },
    new_tab_hover = {
      bg_color = blue,
      fg_color = white,
    },
  },

  ansi = { black, red, green, yellow, blue, magenta, cyan, white },
  brights = { bright_black, bright_red, bright_green, bright_yellow, bright_blue, bright_magenta, bright_cyan, bright_white },
}

-- Keyboard
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1500 }

config.keys = {
  -- Tabs
  { mods = 'CMD',       key = 'p',          action = act.ShowTabNavigator },
  { mods = 'CMD',       key = 't',          action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir } },
  { mods = "CMD|SHIFT", key = "{",          action = act.ActivateTabRelative(-1) },
  { mods = "CMD|SHIFT", key = "}",          action = act.ActivateTabRelative(1) },
  -- Panes
  { mods = 'LEADER',    key = '%',          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { mods = 'LEADER',    key = '"',          action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { mods = "CMD",       key = "m",          action = act.PaneSelect },
  { mods = "CMD",       key = "h",          action = act.ActivatePaneDirection('Left') },
  { mods = "CMD",       key = "j",          action = act.ActivatePaneDirection('Down') },
  { mods = "CMD",       key = "k",          action = act.ActivatePaneDirection('Up') },
  { mods = "CMD",       key = "l",          action = act.ActivatePaneDirection('Right') },
  { mods = 'CMD',       key = 'z',          action = act.TogglePaneZoomState, },
  -- Cursor navigation
  { mods = 'OPT',       key = 'LeftArrow',  action = act.SendString '\x1bb' },
  { mods = 'OPT',       key = 'RightArrow', action = act.SendString '\x1bf' },
  -- Edit the config
  { mods = 'SUPER',     key = ',',          action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir, args = { 'vi', wezterm.config_file } } },
}

-- Format the tab bar
wezterm.on('format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local current_tab_index = tab.tab_index + 1
    local next_tab_index = current_tab_index + 1
    local total_number_of_tabs = #tabs

    local text = ' ' .. tab.active_pane.title .. ' ❲' .. current_tab_index .. '❳ '
    local text_background = bright_black
    if tab.is_active or hover then text_background = blue end
    local text_foreground = white

    local zoom_indicator = ''
    if tab.active_pane.is_zoomed then zoom_indicator = wezterm.nerdfonts.md_fullscreen .. '  ' end

    local separator = ''
    local separator_background = bright_black
    local separator_foreground = black
    if tab.is_active or hover then
      if hover and total_number_of_tabs > current_tab_index and tabs[next_tab_index].is_active then
        separator = ''
        separator_background = blue
        separator_foreground = black
      else
        separator = ''
        if current_tab_index == total_number_of_tabs then
          separator_background = black
        else
          separator_background = bright_black
        end
        separator_foreground = blue
      end
    elseif current_tab_index == total_number_of_tabs then
      separator = ''
      separator_background = black
      separator_foreground = bright_black
    elseif total_number_of_tabs > current_tab_index and tabs[next_tab_index].is_active then
      separator = ''
      separator_background = blue
      separator_foreground = bright_black
    end

    return {
      { Background = { Color = text_background } },      { Foreground = { Color = text_foreground } },      { Text = text },
      { Background = { Color = text_background } },      { Foreground = { Color = yellow } },               { Text = zoom_indicator },
      { Background = { Color = separator_background } }, { Foreground = { Color = separator_foreground } }, { Text = separator },
    }
  end
)

-- Format the status bar
wezterm.on('update-status',
  function(window)
    local date = wezterm.strftime '%a %d %b'
    local time = wezterm.strftime '%H:%M'

    window:set_right_status(wezterm.format({
      { Foreground = { Color = blue } },
      { Text = '' },
      { Background = { Color = blue } },
      { Foreground = { Color = white } },
      { Text = ' ' .. date .. ' ' .. wezterm.nerdfonts.fa_calendar .. '  ' },
      { Background = { Color = blue } },
      { Foreground = { Color = black } },
      { Text = '' },
      { Background = { Color = blue } },
      { Foreground = { Color = white } },
      { Text = ' ' .. time .. ' ' .. wezterm.nerdfonts.fa_clock_o .. '  ' },
    }))
  end
)

return config

