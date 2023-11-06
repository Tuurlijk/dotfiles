-------------------------------------------------
-- CPU Widget for Awesome Window Manager
-- Shows the current CPU utilization
-- Based on:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/cpu-widget
-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local updateInterval = 2

local colors = {
    "#008f00",
    "#008f00",
    "#568e00",
    "#d4c600",
    "#bd7500",
    "#8f0000",
}

-- mirror and push up a bit
local cpuWidget = wibox.widget {
    max_value = 100,
    thickness = 2,
    start_angle = math.pi + math.pi / 2,
    bg = gears.color("#c0c0c020"),
    widget = wibox.container.arcchart
}

local function hideIcon()
    cpuWidget.widget = nul
end

local function showIcon()
    cpuWidget.widget = wibox.widget {
        markup = "<span color='#c0c0c0'></span>",
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
end

local total_prev = 0
local idle_prev = 0

awful.widget.watch(
        "cat /proc/stat | grep '^cpu '",
        updateInterval,
        function(widget, stdout, stderr, exitreason, exitcode)
            local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice = stdout:match('cpu%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')
            local total = user + nice + system + idle + iowait + irq + softirq + steal
            local diff_idle = idle - idle_prev
            local diff_total = total - total_prev
            local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
            local stepSize = 100 / #colors
            local rangeIndex = math.floor(diff_usage / stepSize) + 1
            widget.value = diff_usage
            widget.colors = { colors[rangeIndex] }
            if rangeIndex > #colors then
                widget.colors = { colors[rangeIndex - 1] }
            end

            total_prev = total
            idle_prev = idle
        end,
        cpuWidget
)

local cpuWidgetTooltip = awful.tooltip({
    objects = { cpuWidget },

    timer_function = function()
        return "cpu"
    end,
})

cpuWidget:connect_signal("mouse::enter", function()
    showIcon()
end)
cpuWidget:connect_signal("mouse::leave", function()
    hideIcon()
end)

return wibox.container.margin(
        wibox.container.mirror(
                cpuWidget,
                { horizontal = true }
        ),
        2,
        2,
        2,
        2
)
