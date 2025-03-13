local wezterm = require('wezterm')
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local act = wezterm.action
config.keys = {
    -- {key = 'b', mods = 'CTRL', action = act.SendKey {key = 'b', mods = 'META',},},
    -- {key = 'f', mods = 'CTRL', action = act.SendKey {key = 'f', mods = 'META',},},
    {key = 'f', mods = 'SHIFT|META', action = act.ToggleFullScreen,},
    {key = 'q', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab {confirm = false},},
    {key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration},
    {key = 's', mods = 'SHIFT|CTRL', action = act.SplitHorizontal {domain = 'CurrentPaneDomain'},},
    {key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain',},
    {key = 't', mods = 'META', action = act.ShowTabNavigator,},
    {key = 'v', mods = 'META', action = act.PasteFrom 'Clipboard'},
    {key = 'v', mods = 'SHIFT|CTRL', action = act.SplitVertical {domain = 'CurrentPaneDomain'},},
    {key = '[', mods = 'CTRL', action = act.PaneSelect,},
    {key = 'h', mods = 'LEADER', action = act.AdjustPaneSize {'Left', 5}},
    {key = 'j', mods = 'LEADER', action = act.AdjustPaneSize {'Down', 5}},
    {key = 'k', mods = 'LEADER', action = act.AdjustPaneSize {'Up', 5}},
    {key = 'l', mods = 'LEADER', action = act.AdjustPaneSize {'Right', 5}},
    {key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1)},
    {key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1)},
}

config.audible_bell = 'Disabled'
config.color_scheme = 'Sonokai (Gogh)'
config.default_prog = {'zsh'}
config.font = wezterm.font('Cica', {weight='Regular', stretch='Normal', style='Normal'})
config.font_size = 12
config.initial_cols = 100
config.initial_rows = 50
config.leader = {key = 'a', mods = 'CTRL'}
config.window_background_opacity = 0.85
config.window_close_confirmation = 'NeverPrompt'

return config
