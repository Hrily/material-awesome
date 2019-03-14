local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widgets.task-list')
local gears = require('gears')
local clickable_container = require('widgets.clickable-container')
local mat_icon_button = require('widgets.mat-icon-button')
local apps = require('conf.apps')

local icons = require('theme.icons')
local add_button = mat_icon_button(wibox.widget.imagebox(icons.plus))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)
-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox =
  function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

local TopPanel =
  function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = 48
  end
  local panel =
    wibox(
    {
      ontop = true,
      screen = s,
      height = s.geometry.height,
      width = beautiful.left_panel_width,
      x = s.geometry.x + offsetx,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.dark,
      fg = beautiful.fg_normal,
      struts = {
        left = 24
      }
    }
  )

  panel:struts(
    {
      left = 24
    }
  )

  panel:setup {
    layout = wibox.layout.align.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      -- Create a taglist widget
      wibox.container {
          TaskList(s),
          direction = 'east',
          widget    = wibox.container.rotate
      },
      add_button
    },
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      -- Layout box
      wibox.container.margin(LayoutBox(s), 5, 5, 5, 5)
    }
  }
  print('jan')
  -- local test = panel:get_children_by_id('test')[1]
  gears.debug.dump(test)
  return panel
end

return TopPanel
