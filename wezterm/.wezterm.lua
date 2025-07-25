local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Apple Classic'

config.keys = {
  -- This will create a new vertical split and run your default program inside it
  {
    key = 'v',
    mods = 'ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  }, 
  -- This will create a new horizontal split and run your default program inside it
  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  }, 
  -- Move to the next pane (Ctrl+W)
    {
      key = 'w',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Next',
    },
    -- Move focus to the pane below (Ctrl+Down Arrow)
    {
      key = 'DownArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    -- Move focus to the pane above (Ctrl+Up Arrow)
    {
      key = 'UpArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    -- Move focus to the pane to the right (Ctrl+Right Arrow)
    {
      key = 'RightArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    -- Move focus to the pane to the left (Ctrl+Left Arrow)
    {
      key = 'LeftArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
}

for i = 1, 8 do
  -- ALT + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end


return config
