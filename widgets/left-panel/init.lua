local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TagList = require('widgets.tag-list')
local gears = require('gears')
local apps = require('conf.apps')
local list_icon_item = require('widgets.list-icon-item')
-- Clock / Calendar
local clock_hour = wibox.widget.textclock('<span font="' .. beautiful.font .. ' 8">%H</span>')
local clock_min = wibox.widget.textclock('<span font="' .. beautiful.font .. ' 8">%M</span>')
local clock_widget = {
  layout = wibox.layout.align.vertical(middle),
  forced_width = beautiful.left_panel_width,
  nil,
  {
    layout = wibox.layout.align.horizontal(middle),
    forced_width = beautiful.left_panel_width,
    expand = "outside",
    nil,
    wibox.container.margin(clock_hour, 4, 4, 12, 1),
    nil
  },
  {
    layout = wibox.layout.align.horizontal(middle),
    forced_width = beautiful.left_panel_width,
    expand = "outside",
    nil,
    wibox.container.margin(clock_min, 4, 4, 1, 12),
    nil
  },
}
local systray = wibox.widget.systray()
systray:set_horizontal(false)
local clickable_container = require('widgets.clickable-container')
local icons = require('theme.icons')

local menu_icon =
  wibox.widget {
  image = icons.menu,
  widget = wibox.widget.imagebox
}

local home_button =
  wibox.widget {
  wibox.widget {
    wibox.widget {
      menu_icon,
      top = 4,
      left = 4,
      right = 4,
      bottom = 4,
      widget = wibox.container.margin
    },
    widget = clickable_container
  },
  bg = beautiful.dark,
  widget = wibox.container.background
}

local LeftPanel =
  function(s)
  local panel =
    wibox {
    screen = s,
    width = 424,
    height = s.geometry.height,
    -- x = s.geometry.x + beautiful.left_panel_width - 424,
    x = s.geometry.width - beautiful.left_panel_width,
    y = s.geometry.y,
    ontop = true,
    bg = beautiful.dark,
    fg = beautiful.light
  }

  panel.opened = false

  panel:struts(
    {
      left = beautiful.left_panel_width,
      right = beautiful.left_panel_width
    }
  )

  local backdrop =
    wibox {
    ontop = true,
    screen = s,
    bg = beautiful.dark .. '99',
    type = 'splash',
    x = s.geometry.x,
    y = s.geometry.y,
    width = s.geometry.width,
    height = s.geometry.height
  }

  local run_rofi =
    function()
    -- panel.rofi_pid = awful.spawn(apps.rofi)
    --log_this(panel.rofi_pid)
    awesome.spawn(
      apps.rofi,
      false,
      false,
      false,
      false,
      function()
        panel:toggle()
      end
    )
    --awful.spawn.with_line_callback(apps.rofi, { exit = function() print("rofi exited") end })
  end

  local openPanel = function(should_run_rofi)
    panel.x = panel.x - 400
    menu_icon.image = icons.close
    backdrop.visible = true
    panel.visible = false
    panel.visible = true
    if should_run_rofi then
      run_rofi()
    end
  end

  local closePanel = function()
    menu_icon.image = icons.menu
    panel.x = panel.x + 400
    backdrop.visible = false
  end

  function panel:toggle(should_run_rofi)
    self.opened = not self.opened
    if self.opened then
      openPanel(should_run_rofi)
    else
      closePanel()
    end
  end

  backdrop:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:toggle()
        end
      )
    )
  )

  home_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          panel:toggle()
          --awful.spawn(apps.rofi)
        end
      )
    )
  )

  panel:setup {
    layout = wibox.layout.align.horizontal,
        {
      layout = wibox.layout.align.vertical,
      forced_width = beautiful.left_panel_width,
      {
        -- Left widgets
        layout = wibox.layout.fixed.vertical,
        home_button,
        -- Create a taglist widget
        TagList(s)
      },
      --s.mytasklist, -- Middle widget
      nil,
      {
        -- Right widgets
        layout = wibox.layout.fixed.vertical,
        wibox.container {
          require('widgets.spotify'),
          direction = 'west',
          widget    = wibox.container.rotate
        },
        wibox.container.margin(wibox.widget {}, 8, 8, 24, 24),
        require('widgets.package-updater'),
        wibox.container.margin(systray, 4, 4, 4, 4),
        require('widgets.wifi'),
        require('widgets.battery'),
        -- Clock
        clock_widget
      }
    },
    nil,
    {
      {
        layout = wibox.layout.align.vertical,
        {
          layout = wibox.layout.fixed.vertical,
          {
            list_icon_item(
              {
                icon = icons.search,
                text = 'Search Applications',
                callback = function()
                  run_rofi()
                end
              }
            ),
            bg = beautiful.medium,
            widget = wibox.container.background
          },
          wibox.widget {
            orientation = 'horizontal',
            forced_height = 1,
            opacity = 0.08,
            widget = wibox.widget.separator
          },
          require('widgets.left-panel.quick-settings'),
          require('widgets.left-panel.hardware-monitor'),
          require('widgets.left-panel.info')
        },
        nil,
        {
          layout = wibox.layout.fixed.vertical,
          {
            list_icon_item(
              {
                icon = icons.logout,
                text = 'End work session',
                divider = true,
                callback = function()
                  panel:toggle()
                  exit_screen_show()
                end
              }
            ),
            bg = beautiful.dark,
            widget = wibox.container.background
          }
        }
      },
      bg = beautiful.dark,
      widget = wibox.container.background
    }
  }

  return panel
end

return LeftPanel
