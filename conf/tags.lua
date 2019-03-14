local awful = require('awful')
local wibox = require('wibox')
local iconPath = os.getenv('HOME') .. '/.config/awesome/theme/icons/tag-list/tag/'
local gears = require('gears')

local tags = {
    {
        icon = 'google-chrome.png',
        type = 'chrome',
        defaultApp = 'firefox',
        screen = 1
    },
    {
        icon = 'code-braces.png',
        type = 'code',
        defaultApp = 'code',
        screen = 1
    },
    {
        icon = 'folder.png',
        type = 'files',
        defaultApp = 'nautilus',
        screen = 1
    },
    {
        icon = 'terminal.svg',
        type = 'files',
        defaultApp = 'gnome-terminal',
        screen = 1
    },
    {
        -- 5
        type = 'any',
        screen = 1
    },
    {
        -- 6
        type = 'any',
        screen = 1
    },
    {
        -- 7
        type = 'any',
        screen = 1
    },
    {
        -- 8
        type = 'any',
        screen = 1
    },
    {
        -- 9
        type = 'any',
        screen = 1
    },
    {
        icon = 'music.png',
        type = 'music',
        defaultApp = 'spotify',
        screen = 1
    }
}

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max
}

awful.screen.connect_for_each_screen(
    function(s)
        for i, tag in pairs(tags) do
            local new_tag =
                awful.tag.add(
                i,
                {
                    icon = tag.icon and iconPath .. tag.icon or false,
                    text = tag.text,
                    layout = awful.layout.suit.tile.right,
                    gap_single_client = false,
                    gap = 4,
                    screen = s,
                    defaultApp = tag.defaultApp,
                    selected = i == 1
                }
            )
        end
    end
)

tag.connect_signal(
    'property::layout',
    function(t)
        local currentLayout = awful.tag.getproperty(t, 'layout')
        if (currentLayout == awful.layout.suit.max) then
            t.gap = 0
        else
            t.gap = 4
        end
    end
)
