local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local gears = require('gears')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
theme.primary.hue_500 = '#003f6b'
-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.blue_grey

theme.background.hue_800 = '#192933'
theme.background.hue_900 = '#121e25'

local awesome_overrides =
  function(theme)
    theme.dark = '#0C1015'
    theme.medium = '#676a6d'
    theme.medium_dark = '#474a4d'
    theme.light = '#e1e1e1'
    theme.selected = '#8FBFCF'
    theme.urgent = '#E2C08D'

    theme.wallpaper = os.getenv("HOME") .. '/Pictures/code.png'

    theme.font = 'Karla Bold'
    theme.font_reg = 'Karla Regular'
    theme.title_font = theme.font .. ' 14'
    theme.tooltip_font = theme.font .. ' 10'

    -- Left Panel
    theme.left_panel_width = 24
    theme.bg_systray = theme.dark

    -- TagList
    theme.taglist_font = theme.font .. ' 10'
    theme.taglist_bg_empty = theme.dark
    theme.taglist_bg_occupied = theme.dark
    -- theme.taglist_bg_occupied =
    --   'linear:24,0:0,0:0,' ..
    --   theme.medium .. ':0.07,' .. theme.medium .. ':0.07,' ..
    --   theme.dark .. ':1,' .. theme.dark
    theme.taglist_bg_urgent = 'png:' .. theme.icons .. 'tag-list/urgent.png'
    theme.taglist_bg_focus = 
      'linear:24,0:0,0:0,' ..
      theme.selected .. ':0.07,' .. theme.selected .. ':0.07,' ..
      theme.dark .. ':1,' .. theme.dark

    -- Spotify Widget
    theme.spotify_border = '#73c991'
    theme.spotify_fg = theme.light
    theme.spotify_bg = 
      'linear:0,0:0,24:0,' ..
      theme.spotify_border .. ':0.07,' .. theme.spotify_border .. ':0.07,' ..
      theme.dark .. ':1,' .. theme.dark
    theme.spotify_font = theme.font .. ' 10'
    theme.spotify_play_icon = theme.icons .. '/play.svg'
    theme.spotify_pause_icon = theme.icons .. '/pause.svg'

    -- Tasklist
    theme.tasklist_font = theme.font .. ' 10'
    theme.tasklist_bg_normal = theme.dark
    theme.tasklist_bg_focus = 
      'linear:0,0:0,24:0,' ..
      theme.selected .. ':0.07,' .. theme.selected .. ':0.07,' ..
      theme.dark .. ':1,' .. theme.dark
    theme.tasklist_bg_urgent = 
      'linear:0,0:0,24:0,' ..
      theme.urgent .. ':0.07,' .. theme.urgent .. ':0.07,' ..
      theme.dark .. ':1,' .. theme.dark
    theme.tasklist_fg_urgent = theme.fg_normal
    theme.tasklist_fg_normal = '#999999'
    theme.tasklist_fg_focus = '#ffffff'

    -- Layour
    theme.layout_max = theme.icons .. '/layouts/max.png'
    theme.layout_tile = theme.icons .. '/layouts/tile.png'
    theme.layout_tilebottom = theme.icons .. '/layouts/tile-bottom.png'

    -- Exit Screen
    theme.exit_screen_icon_size = 80

    -- Borders

    theme.border_width = 1
    theme.border_normal = '#2c4e67'
    theme.border_focus = theme.selected
    theme.border_marked = theme.urgent

  --[[   theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
  --theme.dir             = os.getenv("HOME") .. "/code/awesome-pro/themes/pro-dark"

  theme.icons = theme.dir .. '/icons/'
  --theme.wallpaper = theme.dir .. '/wallpapers/pro-dark-shadow.png'
  theme.wallpaper = '#e0e0e0'
  theme.panel = 'png:' .. theme.icons .. 'tag-list/panel.png'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'
  theme.calendar_font = 'Meslo LGS Regular 10'
  theme.fs_font = 'Meslo LGS Regular 10'

  theme.primary = '#003f6b'
  theme.primary_hue_300 = '#174a78'
  theme.primary_hue_800 = '#00345f'

  theme.accent = '#003f6b'
  theme.accent_hue_300 = '#174a78'
  theme.accent_hue_800 = '#00345f'

  theme.appBackground = '#212121'
  theme.background = '#192933'
  theme.panel_bg = '#192933'

  theme.background_hue_800 = '#121e25'

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.appBackground
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background
  theme.bat_bg_critical = '#ff0000'
  theme.clockgf = '#ffffff'

  -- Borders

  theme.border_width = 2
  theme.border_normal = theme.background
  theme.border_focus = theme.primary_hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = 16
  theme.menu_width = 160

  -- Tooltips
  theme.tooltip_bg = '#232323'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 6)
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'

  -- Taglist

  theme.taglist_bg_empty = 'png:' .. theme.icons .. 'tag-list/unselected.png'
  theme.taglist_bg_occupied = 'png:' .. theme.icons .. 'tag-list/unselected.png'
  theme.taglist_bg_urgent = 'png:' .. theme.icons .. 'tag-list/urgent.png'
  theme.taglist_bg_focus = 'png:' .. theme.icons .. 'tag-list/selected.png'

  -- Tasklist

  theme.tasklist_font = 'Roboto medium 11'
  theme.tasklist_bg_normal = theme.background
  theme.tasklist_bg_focus =
    'linear:0,0:0,48:0,' ..
    theme.background .. ':0.95,' .. theme.background .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  -- Misc

  theme.home = theme.dir .. '/icons/magnify.png'
  theme.add = theme.dir .. '/icons/plus.png'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = 2
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.background.hue_800 ]]
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
