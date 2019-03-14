local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widgets.clickable-container')

function build(imagebox, args)

    -- return wibox.container.margin(container, 6, 6, 6, 6)
    return wibox.widget {
        wibox.widget {
            wibox.widget {
              imagebox,
              top = 0,
              left = 0,
              right = 0,
              bottom = 0,
              widget = wibox.container.margin
            },
            shape = gears.shape.circle,
            widget = clickable_container
        },
        top = 2,
        left = 2,
        right = 2,
        bottom = 2,
        widget = wibox.container.margin
    }
end

return build
