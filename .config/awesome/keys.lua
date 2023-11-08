local lain           = require("lain")
local gears          = require("gears")
local awful          = require("awful")
local naughty        = require("naughty")
local hotkeys_popup  = require("awful.hotkeys_popup").widget

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey         = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
-- https://awesomewm.org/apidoc/libraries/awful.layout.html
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

local keys           = {}

keys.modkey          = modkey

keys.globalkeys      = gears.table.join(
		keys.globalkeys,
		awful.key({ modkey }, "b",
		          function()
			          myscreen                 = awful.screen.focused()
			          myscreen.mywibox.visible = not myscreen.mywibox.visible
		          end,
		          { description = "Toggle statusbar", group = "awesome" }
		),

		awful.key({ modkey, }, "s",
		          function()
			          hotkeys_popup.show_help({}, nil, { show_awesome_keys = true })
		          end,
		          { description = "show help", group = "awesome" }),
		awful.key({ modkey, }, "Left",
		          awful.tag.viewprev,
		          { description = "View previous", group = "tag" }),
		awful.key({ modkey, }, "Right",
		          awful.tag.viewnext,
		          { description = "View next", group = "tag" }),
		awful.key({ modkey, }, "Escape",
		          awful.tag.history.restore,
		          { description = "Go back", group = "tag" }),

		awful.key({ "Mod1", }, "Tab",
		          function()
			          awful.client.focus.byidx(1)
		          end,
		          { description = "Focus next by index", group = "client" }),
		awful.key({ "Mod1", "Shift" }, "Tab",
		          function()
			          awful.client.focus.byidx(-1)
		          end,
		          { description = "Focus previous by index", group = "client" }),
		awful.key({ modkey, }, "Tab",
		          function()
			          awful.client.focus.byidx(1)
		          end,
		          { description = "Focus next by index", group = "client" }),
		awful.key({ modkey, "Shift" }, "Tab",
		          function()
			          awful.client.focus.byidx(-1)
		          end,
		          { description = "Focus previous by index", group = "client" }),
		awful.key({ modkey, }, "w",
		          function()
			          mymainmenu:show()
		          end,
		          { description = "show main menu", group = "awesome" }),

-- Layout manipulation
		awful.key({ modkey, "Shift" }, "j",
		          function()
			          awful.client.swap.byidx(1)
		          end,
		          { description = "Swap with next client by index", group = "client" }),
		awful.key({ modkey, "Shift" }, "k",
		          function()
			          awful.client.swap.byidx(-1)
		          end,
		          { description = "Swap with previous client by index", group = "client" }),
		awful.key({ modkey, "Control" }, "j",
		          function()
			          awful.screen.focus_relative(1)
		          end,
		          { description = "Focus the next screen", group = "screen" }),
		awful.key({ modkey, "Control" }, "k",
		          function()
			          awful.screen.focus_relative(-1)
		          end,
		          { description = "Focus the previous screen", group = "screen" }),
		awful.key({ modkey, }, "u",
		          awful.client.urgent.jumpto,
		          { description = "Jump to urgent client", group = "client" }),
		awful.key({ modkey, }, "Escape",
		          function()
			          awful.client.focus.history.previous()
			          if client.focus then
				          client.focus:raise()
			          end
		          end,
		          { description = "Go back", group = "client" }),

-- Standard program
		awful.key({ modkey }, "d",
		          function()
			          awful.util.spawn("synapse")
		          end,
		          { description = "Launcher", group = "launcher" }),
		awful.key({ modkey, }, "Return",
		          function()
			          awful.spawn(terminal)
		          end,
		          { description = "Open a terminal", group = "launcher" }),
		awful.key({ modkey, "Control" }, "r",
		          awesome.restart,
		          { description = "Reload awesome", group = "awesome" }),
		awful.key({ modkey, "Shift" }, "q",
		          awesome.quit,
		          { description = "Quit awesome", group = "awesome" }),
		awful.key({ modkey, }, "BackSpace",
		          function()
			          awful.spawn("slock")
		          end,
		          { description = "Lock screen", group = "awesome" }),

		awful.key({ modkey, "Mod1" }, "Right",
		          function()
			          awful.tag.incmwfact(0.02)
		          end,
		          { description = "Increase client width", group = "client" }),
		awful.key({ modkey, "Mod1" }, "Left",
		          function()
			          awful.tag.incmwfact(-0.02)
		          end,
		          { description = "Decrease client width", group = "client" }),
		awful.key({ modkey, "Mod1" }, "Up",
		          function()
			          awful.client.incwfact(0.02)
		          end,
		          { description = "Increase client height", group = "client" }),
		awful.key({ modkey, "Mod1" }, "Down",
		          function()
			          awful.client.incwfact(-0.02)
		          end,
		          { description = "Decrease client height", group = "client" }),

		awful.key({ modkey, "Shift" }, "h",
		          function()
			          awful.tag.incnmaster(1, nil, true)
		          end,
		          { description = "Increase the number of master clients", group = "layout" }),
		awful.key({ modkey, "Shift" }, "l",
		          function()
			          awful.tag.incnmaster(-1, nil, true)
		          end,
		          { description = "Decrease the number of master clients", group = "layout" }),
		awful.key({ modkey, "Control" }, "h",
		          function()
			          awful.tag.incncol(1, nil, true)
		          end,
		          { description = "Increase the number of columns", group = "layout" }),
		awful.key({ modkey, "Control" }, "l",
		          function()
			          awful.tag.incncol(-1, nil, true)
		          end,
		          { description = "Decrease the number of columns", group = "layout" }),
		awful.key({ modkey, }, "space",
		          function()
			          awful.layout.inc(1)
		          end,
		          { description = "Select next", group = "layout" }),
		awful.key({ modkey, "Shift" }, "space",
		          function()
			          awful.layout.inc(-1)
		          end,
		          { description = "Select previous", group = "layout" }),

		awful.key({ modkey, "Control" }, "n",
		          function()
			          local c = awful.client.restore()
			          -- Focus restored client
			          if c then
				          client.focus = c
				          c:raise()
			          end
		          end,
		          { description = "Restore minimized", group = "client" }),

-- Prompt
		awful.key({ modkey }, "r",
		          function()
			          awful.screen.focused().mypromptbox:run()
		          end,
		          { description = "Run prompt", group = "launcher" }),

		awful.key({ modkey }, "x",
		          function()
			          awful.prompt.run {
				          prompt       = "Run Lua code: ",
				          textbox      = awful.screen.focused().mypromptbox.widget,
				          exe_callback = awful.util.eval,
				          history_path = awful.util.get_cache_dir() .. "/history_eval"
			          }
		          end,
		          { description = "Lua execute prompt", group = "awesome" }),

-- Brightness
		awful.key({ }, "XF86MonBrightnessUp",
		          function()
			          awful.util.spawn("light -A 5")
		          end,
		          { description = "5%", group = "hotkeys" }),
		awful.key({ }, "XF86MonBrightnessDown",
		          function()
			          awful.util.spawn("light -U 5")
		          end,
		          { description = "5%", group = "hotkeys" }),

-- Volume
		awful.key({}, "XF86AudioMute",
		          function()
			          awful.spawn("pactl set-sink-mute 0 toggle")
		          end,
		          { description = "toggle mute", group = "hotkeys" }),
		awful.key({}, "XF86AudioRaiseVolume",
		          function()
			          awful.spawn("amixer -D pipewire sset Master 3%+")
			          awful.spawn("paplay /usr/share/sounds/freedesktop/stereo/bell.oga")
		          end,
		          { description = "3%", group = "hotkeys" }),
		awful.key({}, "XF86AudioLowerVolume",
		          function()
			          awful.spawn("amixer -D pipewire sset Master 3%-")
			          awful.spawn("paplay /usr/share/sounds/freedesktop/stereo/bell.oga")
		          end,
		          { description = "3%", group = "hotkeys" }))

keys.clientkeys      = gears.table.join(
		keys.clientkeys,

		awful.key({ modkey, "Control", "Shift" }, "j",
		          function(c)
			          c:move_to_screen(c.screen.index + 1)
		          end,
		          { description = "move to screen right", group = "client" }),
		awful.key({ modkey, "Control", "Shift" }, "k",
		          function(c)
			          c:move_to_screen(c.screen.index - 1)
		          end,
		          { description = "move to screen left", group = "client" }),

		awful.key({ modkey, "Shift" }, "Down",
		          function(c)
			          c:relative_move(0, 10, 0, 0)
		          end,
		          { description = "   Move window down", group = "float" }),
		awful.key({ modkey, "Shift" }, "Up",
		          function(c)
			          c:relative_move(0, -10, 0, 0)
		          end,
		          { description = "   Move window up", group = "float" }),
		awful.key({ modkey, "Shift" }, "Left",
		          function(c)
			          c:relative_move(-10, 0, 0, 0)
		          end,
		          { description = "   Move window left", group = "float" }),
		awful.key({ modkey, "Shift" }, "Right",
		          function(c)
			          c:relative_move(10, 0, 0, 0)
		          end,
		          { description = "   Move window right", group = "float" }),

		awful.key({ modkey, "Control" }, "Down",
		          function(c)
			          c:relative_move(10, 10, -40, -40)
		          end,
		          { description = "   Shrink window", group = "float" }),
		awful.key({ modkey, "Control" }, "Up",
		          function(c)
			          c:relative_move(-10, -10, 40, 40)
		          end,
		          { description = "   Grow window", group = "float" }),
		awful.key({ modkey, "Control" }, "Left",
		          function(c)
			          c.floating = true
			          local axis = 'vertically'
			          local f    = awful.placement.scale
					          + awful.placement.left
					          + (axis and awful.placement['maximize_' .. axis] or nil)
			          local geo  = f(client.focus, { honor_workarea = true, to_percent = 0.5 })
		          end,
		          { description = "   Snap left", group = "float" }),
		awful.key({ modkey, "Control" }, "Right",
		          function(c)
			          c.floating = true
			          local axis = 'vertically'
			          local f    = awful.placement.scale
					          + awful.placement.right
					          + (axis and awful.placement['maximize_' .. axis] or nil)
			          local geo  = f(client.focus, { honor_workarea = true, to_percent = 0.5 })
		          end,
		          { description = "   Snap Right", group = "float" }),

		awful.key({ }, "F11",
		          function(c)
			          c.fullscreen = not c.fullscreen
			          c:raise()
		          end,
		          { description = "Toggle fullscreen", group = "client" }),
		awful.key({ "Mod1" }, "F4",
		          function(c)
			          c:kill()
		          end,
		          { description = "Close", group = "client" }),
		awful.key({ modkey }, "k",
		          function(c)
			          if c.pid then
				          awful.spawn("kill -9 " .. c.pid)
			          end
		          end,
		          { description = "Kill", group = "client" }),
		awful.key({ "Control" }, "q",
		          function(c)
			          c:kill()
		          end,
		          { description = "Close", group = "client" }),
		awful.key({ modkey, "Control" }, "space",
		          awful.client.floating.toggle,
		          { description = "   Toggle floating", group = "float" }),
		awful.key({ modkey, "Control" }, "Return",
		          function(c)
			          c:swap(awful.client.getmaster())
		          end,
		          { description = "Move to master", group = "client" }),
		awful.key({ modkey, }, "o",
		          function(c)
			          c:move_to_screen()
		          end,
		          { description = "Move to screen", group = "client" }),
		awful.key({ modkey, }, "t",
		          function(c)
			          c.ontop = not c.ontop
		          end,
		          { description = "Toggle keep on top", group = "client" }),
		awful.key({ modkey, }, "z",
		          function(c)
			          c.sticky = not c.sticky
		          end,
		          { description = "Toggle sticky", group = "client" }),
		awful.key({ modkey, }, "n",
		          function(c)
			          -- The client currently has the input focus, so it cannot be
			          -- minimized, since minimized clients can't have the focus.
			          c.minimized = true
		          end,
		          { description = "Minimize", group = "client" }),
		awful.key({ modkey, }, "m",
		          function(c)
			          c.maximized = not c.maximized
			          c:raise()
		          end,
		          { description = "(un)maximize", group = "client" }),
		awful.key({ modkey, "Shift" }, "m",
		          function(c)
			          c.maximized_horizontal = not c.maximized_horizontal
			          c:raise()
		          end,
		          { description = "(un)maximize horizontally", group = "client" }),
		awful.key({ modkey, "Control", "Shift" }, "m",
		          function(c)
			          c.maximized_vertical = not c.maximized_vertical
			          c:raise()
		          end,
		          { description = "(un)maximize vertically", group = "client" }),
		awful.key({ modkey, "Shift" }, "t",
		          awful.titlebar.toggle,
		          { description = "Toggle titlebar", group = "client" }),
		awful.key({ modkey, "Control" }, "m",
		          lain.util.magnify_client,
		          { description = "Magnify client", group = "client" }),
		awful.key({ modkey, "Control", "Shift" }, "n",
		          function()
			          naughty.notify {
				          text  = "Test notification to see how the notification looks with the current theme styling.",
				          title = "Some title for the note",
				          icon  = os.getenv("HOME") .. "/.config/awesome/themes/macos-dark/icons/awesome.png"
			          }
		          end,
		          { description = "Notification test", group = "client" })
)

awful.keyboard.append_global_keybindings(
		{
			awful.key {
				modifiers   = { modkey },
				keygroup    = "numrow",
				description = "only view tag",
				group       = "tag",
				on_press    = function(index)
					local screen = awful.screen.focused()
					local tag    = screen.tags[index]
					if tag then
						tag:view_only()
					end
				end,
			},
			awful.key {
				modifiers   = { modkey, "Control" },
				keygroup    = "numrow",
				description = "toggle tag",
				group       = "tag",
				on_press    = function(index)
					local screen = awful.screen.focused()
					local tag    = screen.tags[index]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
			},
			awful.key {
				modifiers   = { modkey, "Shift" },
				keygroup    = "numrow",
				description = "move focused client to tag",
				group       = "tag",
				on_press    = function(index)
					if client.focus then
						local tag = client.focus.screen.tags[index]
						if tag then
							client.focus:move_to_tag(tag)
						end
					end
				end,
			},
			awful.key {
				modifiers   = { modkey, "Control", "Shift" },
				keygroup    = "numrow",
				description = "toggle focused client on tag",
				group       = "tag",
				on_press    = function(index)
					if client.focus then
						local tag = client.focus.screen.tags[index]
						if tag then
							client.focus:toggle_tag(tag)
						end
					end
				end,
			},
			--awful.key {
			--    modifiers = { modkey },
			--    keygroup = "numpad",
			--    description = "select layout directly",
			--    group = "layout",
			--    on_press = function(index)
			--        local t = awful.screen.focused().selected_tag
			--        if t then
			--            t.layout = t.layouts[index] or t.layout
			--        end
			--    end,
			--}
		}
)

return keys
