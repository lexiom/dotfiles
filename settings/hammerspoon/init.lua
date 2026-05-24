-- Applications
hs.hotkey.bind({"cmd"}, "1", function()
  hs.application.launchOrFocus("Chromium")
end)

hs.hotkey.bind({"cmd"}, "2", function()
  hs.application.launchOrFocus("Ghostty")
end)

hs.hotkey.bind({"cmd"}, "3", function()
  hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind({"cmd"}, "4", function()
  hs.application.launchOrFocus("KeePassXC")
end)

hs.hotkey.bind({"cmd"}, "5", function()
  hs.application.launchOrFocus("Music")
end)

hs.hotkey.bind({"cmd", "ctrl"}, "S", function()
  hs.application.launchOrFocus("System Settings")
end)

-- Actions
-- hs.hotkey.bind({"ctrl"}, "v", function()
--   hs.timer.doAfter(0.15, function()
--     hs.eventtap.keyStroke({"cmd"}, "v")
--   end)
-- end)

-- Misc
hs.hotkey.bind({"cmd", "ctrl"}, "-", function()
  hs.reload()
end)

-- hs.alert.show("Config loaded")
