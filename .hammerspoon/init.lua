local hyper = { "ctrl", "alt", "shift" }

-- config reload
hs.hotkey.bind(hyper, "0", function()
   hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()



-- quick launch apps
local applicationHotkeys = {
  y = 'Slack',
  o = 'iTerm',
  i = 'Brave Browser',
  u = 'Alacritty',
  p = 'Spotify',
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end
