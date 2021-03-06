-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library/home/michiel/Projects/Awesome/awesome-config
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Third pary libraries
local freedesktop = require("freedesktop")
local battery_widget = require("widgets.battery")
local cpu_widget = require("widgets.cpu")
local volumeWidget = require("widgets.volume")

local keys = require("keys")

root.keys(keys.globalkeys)

-- Error handling
require("errorHandling")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/macos-dark/theme.lua")

-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- user defined
local listBorderRadius = 0
local titlebarBorderradius = 0
local titlebarHeight = 8
local separatorWidth = 5

-- set gaps
beautiful.useless_gap = 4
beautiful.gap_single_client = true

-- Separator widget
local function separator (width)
    return wibox.widget {
        widget = wibox.widget.textbox,
        forced_width = width or separatorWidth
    }
end

-- Create shape for use in task- and taglist
local listShape = function(cr, width, height, tl, tr, br, bl, rad)
    gears.shape.partially_rounded_rect(cr, width, height, true, true, br, bl, listBorderRadius)
end

-- Create shape for use in a client
local clientShape = function(cr, width, height, tl, tr, br, bl, rad)
    gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, titlebarBorderradius)
end

require("autostart")

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "Hotkeys", function() return false, hotkeys_popup.show_help end },
    { "Manual", terminal .. " -e man awesome" },
    { "Edit config", editor_cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end }
}

mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %b %d %Y, %H:%M")
-- Attach calendar to clock
local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach(mytextclock, "tr")

-- Create a calendar widget
-- myCalendar = widget.calendar_popup()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ keys.modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ keys.modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end))

local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
            c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
    end
end),
    awful.button({}, 3, client_menu_toggle_fn()),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = wibox.container.margin(
            awful.widget.taglist(
                    s,
                    awful.widget.taglist.filter.all,
                    taglist_buttons,
                    {
                        shape_border_width = 1,
                        shape_border_color = '#a0a0a0f0',
                        shape = gears.shape.circle,
                        spacing = separatorWidth
                    }
            ),
            0,
            0,
            2,
            2
    )

    -- Create a tasklist widget
    s.mytasklist = wibox.container.margin(
            awful.widget.tasklist(
                    s,
                    awful.widget.tasklist.filter.currenttags,
                    tasklist_buttons,
                    {
                        shape_border_width = 1,
                        shape_border_color = '#a0a0a0a0',
                        shape = listShape,
                        spacing = separatorWidth
                    }
            ),
            0,
            0,
            2,
            -1
    )

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = 'bottom',
        screen = s,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
            separator(),
        },
        s.mytasklist, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            separator(),
            volumeWidget,
            separator(),
            cpu_widget,
            separator(),
            battery_widget,
            separator(),
            wibox.widget.systray(),
            separator(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)))
-- }}}

clientButtons = gears.table.join(awful.button({}, 1, function(c) client.focus = c; c:raise() end),
    awful.button({ keys.modkey }, 1, awful.mouse.client.move),
    awful.button({ keys.modkey }, 3, awful.mouse.client.resize))

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = clientButtons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
            },
            class = {
                "Arandr",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "pinentry",
                "veromix",
                "xtightvncviewer",
                "jetbrains-*"
            },
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            }

        },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = true }
    },

    -- Remove titlebars from clients that provide custom close buttons
    {
        rule_any = {
            class = {
                "Gedit",
                "Gnome-.*",
                "Nautilus",
                "Org.gnome.DejaDup",
                "Pamac-.*"
            }
        },
        properties = { titlebars_enabled = false }
    },

    {
        rule = {
            class = "jetbrains-.*",
        },
        properties = { focus = true }
    },

    {
        rule = {
            class = "jetbrains-.*",
            name = "win.*"
        },
        properties = { titlebars_enabled = false, focusable = false, focus = true, floating = true, placement = awful.placement.restore }
    },

    -- Set Firefox to always map on the tag named ""
    {
        rule_any = {
            class = {
                "Chromium",
                "Firefox"
            }
        },
        properties = { tag = keys.tags[1] }
    },

    {
        rule_any = {
            class = { "MPlayer", "Nitrogen" },
            instance = { "xterm" }
        },
        properties = { floating = true }
    },

    {
        rule_any = {
            class = {
                "HipChat",
                "Keybase",
                "Slack"
            }
        },
        properties = { tag = keys.tags[2] }
    },

    { rule = { class = "Gimp-2.10" },
      properties = { tag = keys.tags[4], floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    c.shape = clientShape

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
            not c.size_hints.user_position
            and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
            awful.button({}, 1, function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end),
            awful.button({}, 3, function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
            end)
    )

    --if c.floating then
    --    local floatButton = awful.titlebar.widget.floatingbutton(c)
    --else
    --    local floatButton = nil
    --end

    awful.titlebar(c, { size = titlebarHeight, position = "top" }):setup {
        {
            -- Left
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        {
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        {
            -- Right
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

    -- Bottom bar for easy resizing of floating windows
--    awful.titlebar(c, { size = titlebarHeight, position = "bottom", bg_normal = "#00000000" }):setup {
--        { -- Left
--            awful.titlebar.widget.iconwidget(c),
--            buttons = buttons,
--            layout  = wibox.layout.fixed.horizontal
--        },
--        {
--            buttons = buttons,
--            layout = wibox.layout.flex.horizontal
--        },
--        layout = wibox.layout.flex.horizontal
--    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- vim: tabstop=4 shiftwidth=4 expandtab
