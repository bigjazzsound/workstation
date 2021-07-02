local inspect = hs.inspect.inspect

hs.hotkey.bind({"alt"}, "h", function()
  local win = hs.window.focusedWindow()
  local west = win:windowsToWest()
  win:focusWindowWest(west)
end)

hs.hotkey.bind({"alt"}, "l", function()
  local win = hs.window.focusedWindow()
  local east = win:windowsToEast()
  win:focusWindowEast(east)
end)

hs.hotkey.bind({"alt"}, "j", function()
  local win = hs.window.focusedWindow()
  local south = win:windowsToSouth()
  win:focusWindowSouth(south)
end)

hs.hotkey.bind({"alt"}, "k", function()
  local win = hs.window.focusedWindow()
  local north = win:windowsToNorth()
  win:focusWindowNorth(north)
end)

hs.hotkey.bind({"alt", "shift"}, "h", function()
  hs.execute("/usr/local/bin/yabai -m window --warp west")
end)

hs.hotkey.bind({"alt", "shift"}, "l", function()
  hs.execute("/usr/local/bin/yabai -m window --warp east")
end)

-- I cannot get this to work with iteration
hs.hotkey.bind({"alt"}, "1", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 1")
end)

hs.hotkey.bind({"alt"}, "2", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 2")
end)

hs.hotkey.bind({"alt"}, "3", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 3")
end)

hs.hotkey.bind({"alt"}, "4", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 4")
end)

hs.hotkey.bind({"alt"}, "5", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 5")
end)

hs.hotkey.bind({"alt"}, "6", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 6")
end)

hs.hotkey.bind({"alt"}, "7", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 7")
end)

hs.hotkey.bind({"alt"}, "8", function()
  hs.execute("/usr/local/bin/yabai -m space --focus 8")
end)

hs.hotkey.bind({"alt", "shift"}, "1", function()
  hs.execute("/usr/local/bin/yabai -m window --space 1")
  hs.execute("/usr/local/bin/yabai -m space --focus 1")
end)

hs.hotkey.bind({"alt", "shift"}, "2", function()
  hs.execute("/usr/local/bin/yabai -m window --space 2")
  hs.execute("/usr/local/bin/yabai -m space --focus 2")
end)

hs.hotkey.bind({"alt", "shift"}, "3", function()
  hs.execute("/usr/local/bin/yabai -m window --space 3")
  hs.execute("/usr/local/bin/yabai -m space --focus 3")
end)

hs.hotkey.bind({"alt", "shift"}, "4", function()
  hs.execute("/usr/local/bin/yabai -m window --space 4")
  hs.execute("/usr/local/bin/yabai -m space --focus 4")
end)

hs.hotkey.bind({"alt", "shift"}, "5", function()
  hs.execute("/usr/local/bin/yabai -m window --space 5")
  hs.execute("/usr/local/bin/yabai -m space --focus 5")
end)

hs.hotkey.bind({"alt", "shift"}, "6", function()
  hs.execute("/usr/local/bin/yabai -m window --space 6")
  hs.execute("/usr/local/bin/yabai -m space --focus 6")
end)

hs.hotkey.bind({"alt", "shift"}, "7", function()
  hs.execute("/usr/local/bin/yabai -m window --space 7")
  hs.execute("/usr/local/bin/yabai -m space --focus 7")
end)

hs.hotkey.bind({"alt", "shift"}, "8", function()
  hs.execute("/usr/local/bin/yabai -m window --space 8")
  hs.execute("/usr/local/bin/yabai -m space --focus 8")
end)

local function reload_config(files)
    local reload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            reload = true
        end
    end
    if reload then
        hs.reload()
    end
end

local watcher = hs.pathwatcher.new(os.getenv("HOME").."/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")
