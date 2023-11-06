--[[
    macos dark awesome wm theme

    based on
      Copland Awesome WM config
      https://github.com/copycat-killer
      https://github.com/dj95/awesome-macos

--]]

local gears = require("gears")
local dpi   = require("beautiful.xresources").apply_dpi

local titleBarBorderRadius = 6

local hotkeysShape = function(cr, width, height, tl, tr, br, bl, rad)
    gears.shape.rounded_rect(cr, width, height, titleBarBorderRadius)
end

theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/.config/awesome/themes/macos-dark"
theme.wallpaper                     = os.getenv("HOME") .. "/dotfiles/Background/paardebloem.jpg"

theme.icon_theme                    = "Adwaita"

theme.font                          = "Ubuntu Nerd Font 11"
theme.fg_focus                      = "#f0f0f0"
theme.fg_normal                     = "#ffffff"
theme.fg_urgent                     = "#8f0000"
theme.bg_focus                      = "#101010a0"
theme.bg_normal                     = "#202020a0"
theme.bg_urgent                     = "#121212"
theme.border_width                  = 0
theme.border_normal                 = "#121212"
theme.border_focus                  = "#848484"

theme.tasklist_fg_focus             = "#f0f0f0"
theme.tasklist_fg_normal            = "#f0f0f0"
theme.tasklist_bg_focus             = "#101010d0"
theme.tasklist_bg_normal            = "#404040d0"
theme.bg_systray                    = "#40404000"

theme.titlebar_bg_normal            = "#202020b0"
theme.titlebar_bg_focus             = "#101010d0"

theme.menu_height                   = dpi(24)
theme.menu_width                    = dpi(200)

theme.wibar_bg                      = "#00000060"
theme.wibar_fg                      = "#f0f0f0f0"

theme.hotkeys_bg                    = "png:" .. os.getenv("HOME") .. "/dotfiles/Background/dwm-mypattern.jpg"
theme.hotkeys_fg                    = "#f0f0f0"
theme.hotkeys_font                  = "Ubuntu Nerd Font 12"
theme.hotkeys_description_font      = "Ubuntu Nerd Font 12"
theme.hotkeys_label_fg              = "#101010"
theme.hotkeys_modifiers_fg          = "#808080"
theme.hotkeys_shape                 = hotkeysShape
theme.hotkeys_group_margin          = dpi(20)

theme.notification_bg                           = "#101010a0"
theme.notification_fg                           = "#f0f0f0"
theme.notification_width                        = dpi(550)
theme.notification_border_color                 = "#202020a0"
theme.notification_shape                        = hotkeysShape
theme.notification_margin                       = dpi(10)
theme.notification_font                         = "Ubuntu Nerd Font 13"
theme.notification_position                     = 'top_right'
theme.notification_spacing                      = dpi(15)
theme.notification_icon_resize_strategy         = 'center'
theme.notification_icon_size                    = dpi(100)

theme.tasklist_sticky                           = "<span color='#ff2cf3'>■ </span>"
theme.tasklist_ontop                            = "<span color='#d8d8d8'>■ </span>"
theme.tasklist_floating                         = "<span color='#1940ff'>■ </span>"
theme.tasklist_maximized                        = "<span color='#0dbc00'>■ </span>"
theme.tasklist_maximized_horizontal             = "<span color='#0dbc00'>■ </span>"
theme.tasklist_maximized_vertical               = "<span color='#0dbc00'>■ </span>"
theme.tasklist_disable_icon                     = false

theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.submenu_icon                              = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.widget_bg                                 = theme.dir .. "/icons/widget_bg.png"
theme.vol                                       = theme.dir .. "/icons/vol.png"
theme.vol_low                                   = theme.dir .. "/icons/vol_low.png"
theme.vol_no                                    = theme.dir .. "/icons/vol_no.png"
theme.vol_mute                                  = theme.dir .. "/icons/vol_mute.png"
theme.disk                                      = theme.dir .. "/icons/disk.png"
theme.ac                                        = theme.dir .. "/icons/ac.png"
theme.bat                                       = theme.dir .. "/icons/bat.png"
theme.bat_low                                   = theme.dir .. "/icons/bat_low.png"
theme.bat_no                                    = theme.dir .. "/icons/bat_no.png"
theme.play                                      = theme.dir .. "/icons/play.png"
theme.pause                                     = theme.dir .. "/icons/pause.png"

theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/trance.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/trance.png"

theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/trance.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/trance.png"

theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/trance.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/trance.png"

theme.titlebar_minimize_button_focus            = theme.dir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_normal           = theme.dir .. "/icons/titlebar/minimize_normal.png"

theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

-- lain related
theme.useless_gap_width                         = dpi(15)
theme.layout_centerfair                         = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair                           = theme.dir .. "/icons/termfair.png"
theme.layout_centerwork                         = theme.dir .. "/icons/centerwork.png"
theme.layout_uselessfair                        = theme.dir .. "/icons/fairv.png"
theme.layout_uselessfairh                       = theme.dir .. "/icons/fairh.png"
theme.layout_uselessdwindle                     = theme.dir .. "/icons/dwindle.png"
theme.layout_uselesstile                        = theme.dir .. "/icons/tile.png"
theme.layout_uselesstiletop                     = theme.dir .. "/icons/tiletop.png"
theme.layout_uselesstileleft                    = theme.dir .. "/icons/tileleft.png"
theme.layout_uselesstilebottom                  = theme.dir .. "/icons/tilebottom.png"
theme.layout_uselesspiral                       = theme.dir .. "/icons/spiral.png"

return theme
