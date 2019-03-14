local wibox = require('wibox')
local mat_list_item = require('widgets.mat-list-item')
local mat_slider = require('widgets.mat-slider')
local mat_icon_button = require('widgets.mat-icon-button')
local clickable_container = require('widgets.clickable-container')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local slider =
wibox.widget {
  font = beautiful.font_reg .. ' 8',
  align = 'left',
  valign = 'center',
  forced_height = 48,
  widget = wibox.widget.textbox
}

local icon =
  wibox.widget {
  image = icons.eth,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)
button.top = 12
button.bottom = 12
button.left = 12
button.right = 12

local eth_info =
  wibox.widget {
  button,
  wibox.container.margin(slider, dpi(0), dpi(0), dpi(12), dpi(0)),
  widget = mat_list_item
}

eth_info:connect_signal(
  'button::release',
  function()
    awful.spawn.with_shell("bash -c \"~/.config/awesome/scripts/eth-info.sh\" | awk '{print $3}' | xclip -sel clip")
    naughty.notify({ text = "IP copied to clipboard"})
    screen.primary.left_panel:toggle(true)
  end
)

watch(
  "bash -c \"~/.config/awesome/scripts/eth-info.sh\"",
  5,
  function(widget, stdout, stderr, exitreason, exitcode)
    if exitcode == 0 then
        eth_info.visible = true
        slider:set_markup(stdout)
    else
        eth_info.visible = false
    end
  end
)

return eth_info
