local ipairs, string = ipairs, string
local awful = require("awful")

-- Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace - 1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

-- entries must be comma-separated
run_once({
    "/usr/lib/gsd-xsettings",
    "dex -a -e awesome",

    "synapse -s",
    "udiskie",
    "picom -b",
    "autorandr -c",

    "setxkbmap -layout us",

    -- Switch Wacom pen buttons; click button is secondary
    --"xinput set-prop 'Wacom Intuos PT M Pen stylus' 293 1572865",
    --"xinput set-prop 'Wacom Intuos PT M Pen stylus' 294 1572867",

    "xinput set-prop 'Synaptics TM3418-002' 'libinput Tapping Enabled' 1",
    "xinput set-prop 'Synaptics TM3418-002' 'libinput Natural Scrolling Enabled' 1",
    "xinput set-prop 'Synaptics TM3418-002' 'libinput Disable While Typing Enabled' 1",
})
run_once({ "nm-applet -sm-disable" }) -- Network manager tray icon
