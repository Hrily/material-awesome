-------------------------------------------------
-- Spotify Widget for Awesome Window Manager
-- Shows currently playing song on Spotify for Linux client
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-widget

-- @author Pavel Makhov
-- @copyright 2018 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local beautiful = require('beautiful')
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local naughty = require("naughty")

local GET_STATUS = "/usr/bin/python " .. os.getenv("HOME") .. "/.config/awesome/scripts/spotify_status.py -p '0,1' -f '{play_pause} {song} - {artist}'"

local PLAY_PAUSE = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
local NEXT = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
local PREV = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"

local spotify_widget = 
wibox.widget {
    wibox.widget {
        id = "widget",
        {
            id = "icon_margin",
            {
                id = "icon",
                widget = wibox.widget.imagebox,
            },
            top = 4,
            bottom = 4,
            left = 4,
            right = 4,
            widget = wibox.container.margin
        },
        {
            id = "current_song_margin",
            {
                id = 'current_song',
                widget = wibox.widget.textbox,
                font = beautiful.spotify_font,
            },
            right = 4,
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal,
        forced_height = beautiful.left_panel_height,
        fg = beautiful.spotify_fg,
    },
    fg = beautiful.spotify_fg,
    bg = beautiful.spotify_bg,
    widget = wibox.container.background,
    is_playing = function(self, playing)
        self.widget.icon_margin:set_margins(4, 4, 4, 4)
        self.widget.icon_margin.icon.image =
            (playing and beautiful.spotify_pause_icon
            or beautiful.spotify_play_icon)
    end,
    set_text = function(self, text)
        self.widget.current_song_margin.current_song.markup = text
    end,
}

local update_widget_status = function(widget, stdout, stderr, exitreason, exitcode)
    if string.len(stdout) < 2 then
        widget.visible = false
        return
    end
    widget.visible = true
    play_pause = string.sub(stdout, 0, 1)
    text = string.sub(stdout, 2)
    widget:is_playing(play_pause == "0")
    widget:set_text(text)
end

watch(GET_STATUS, 1, update_widget_status, spotify_widget)

--- Adds mouse controls to the widget:
--  - left click - play/pause
--  - scroll up - play next song
--  - scroll down - play previous song
spotify_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn(PLAY_PAUSE, false)      -- left click
    elseif (button == 4) then awful.spawn(NEXT, false)  -- scroll up
    elseif (button == 5) then awful.spawn(PREV, false)  -- scroll down
    end
    awful.spawn.easy_async(GET_STATUS, function(stdout, stderr, exitreason, exitcode)
        update_widget_status(spotify_widget, stdout, stderr, exitreason, exitcode)
    end)
end)

return spotify_widget