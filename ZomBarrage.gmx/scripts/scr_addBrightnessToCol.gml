///scr_addBrightnessToCol(color, brightness);
// Will add or subtract brightness from an rgb color.
// ex. -1 will make it darker by 1, 1 will make it brighter by 1

var _color = argument0;
var _brightness = argument1;

var r = clamp(colour_get_red(_color) + _brightness, 0, 255);
var g = clamp(colour_get_green(_color) + _brightness, 0, 255);
var b = clamp(colour_get_blue(_color) + _brightness, 0, 255);
var finalCol = make_colour_rgb(r, g, b);

return finalCol;