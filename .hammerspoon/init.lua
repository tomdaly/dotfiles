local hyper = { "ctrl", "alt", "cmd" }

-- config reload
hs.hotkey.bind(hyper, "0", function()
   hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()



-- quick launch apps
local applicationHotkeys = {
  b = 'Brave Browser',
  o = 'Obsidian',
  s = 'Slack',
  t = 'Alacritty', -- T for Terminal
  m = 'Spotify', -- M for Music
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end