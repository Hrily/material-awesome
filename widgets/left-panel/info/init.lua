local wibox = require('wibox')
local beautiful = require('beautiful')
local mat_list_item = require('widgets.mat-list-item')

local title = wibox.widget {
  text = 'Info',
  font = beautiful.font .. ' 10',
  widget = wibox.widget.textbox
}
title = wibox.container.margin(title, 69, 12, 24, 12);

return wibox.widget {
  title,
  require('widgets.left-panel.info.date-time'),
  require('widgets.left-panel.info.wifi'),
  require('widgets.left-panel.info.eth'),
  layout = wibox.layout.fixed.vertical
}
