local filesystem = require('gears.filesystem')

return {
    terminal = 'gnome-terminal',
    editor = 'code',
    rofi = 'rofi -show drun -theme ' .. filesystem.get_configuration_dir() .. '/conf/rofi.rasi'
}
