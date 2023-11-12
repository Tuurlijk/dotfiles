-------------------------------------------------
-- Volume Widget for Awesome Window Manager
-- Shows the current volume
-------------------------------------------------

local awful          = require("awful")
local gears          = require("gears")
local wibox          = require("wibox")

local updateInterval = 2

local colors         = {
	"#008f00",
}
local colors_mute    = {
	"#8f0000",
}

local volumeWidget   = wibox.widget {
	max_value   = 100,
	thickness   = 2,
	start_angle = math.pi + math.pi / 2,
	bg          = gears.color("#c0c0c020"),
	widget      = wibox.container.arcchart
}

local function hideIcon()
	volumeWidget.widget = nul
end

local function showIcon()
	volumeWidget.widget = wibox.widget {
		markup  = "<span color='#c0c0c0'></span>",
		align   = 'center',
		valign  = 'center',
		widget  = wibox.widget.textbox,
		buttons = awful.util.table.join(
				awful.button({}, 1, function()
					awful.spawn('pavucontrol')
				end),
				awful.button({ }, 5, function()
					awful.spawn("amixer -D pipewire sset Master 3%+")
				end),
				awful.button({ }, 4, function()
					awful.spawn("amixer -D pipewire sset Master 3%-")
				end)
		)
	}
end

local lastVolume = 0
local muted

awful.widget.watch(
		"wpctl get-volume @DEFAULT_AUDIO_SINK@",
		updateInterval,
		function(widget, stdout, stderr, exitreason, exitcode)
			local volume     = stdout:match('%d.(%d%d)')
			muted            = stdout:match('(%[MUTED%])')
			local stepSize   = 100 / #colors
			local rangeIndex = math.floor(volume / stepSize) + 1
			lastVolume       = volume
			widget.value     = volume

			if (muted ~= nil) then
				widget.colors = { colors_mute[1] }
			else
				widget.colors = { colors[rangeIndex] }
			end
		end,
		volumeWidget
)

local volumeWidgetTooltip = awful.tooltip(
		{
			objects        = { volumeWidget },
			timer_function = function()
				if (muted ~= nil) then
					return "Volume: " .. lastVolume .. " - MUTED"
				else
					return "Volume: " .. lastVolume
				end
			end,
		})

volumeWidget:connect_signal("mouse::enter", function()
	showIcon()
end)
volumeWidget:connect_signal("mouse::leave", function()
	hideIcon()
end)

return wibox.container.margin(
		wibox.container.mirror(
				volumeWidget,
				{ horizontal = true }
		),
		2,
		2,
		2,
		2
)
