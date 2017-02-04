///scr_drawLightBeam(x, y, brightness, color, angle, coneWidth, distance);
/* Draws a triangle / beam of light from a location in a certain angle,
 * to a certain distance.
 * Note that the triangle points must be manually rotated.
*/
// WARNING: THIS MUST BE CREATED IN A END_STEP EVENT, ELSE WEIRD THINGS HAPPEN
var _x = argument0;
var _y = argument1;
var _brightness = argument2;
var _color = argument3;
var _angle = argument4;
var _coneWidth = argument5;
var _distance = argument6;

// First set the coordinates based on angles and cone width
// We are creating a triangle facing right (0 degrees) then adding rotations to it
var x1 = _x;
var y1 = _y;
/*
var x2 = _x + lengthdir_x(_distance, _angle - _coneWidth / 2);
var y2 = _y + lengthdir_y(_distance, _angle - _coneWidth / 2);
var x3 = _x + lengthdir_x(_distance, _angle + _coneWidth / 2);
var y3 = _y + lengthdir_y(_distance, _angle + _coneWidth / 2);
*/
var x2 = _x + lengthdir_x(_distance, _angle) + lengthdir_x(_distance, _angle - _coneWidth / 2);
var y2 = _y + lengthdir_y(_distance, _angle) + lengthdir_y(_distance, _angle - _coneWidth / 2);
var x3 = _x + lengthdir_x(_distance, _angle) + lengthdir_x(_distance, _angle + _coneWidth / 2);
var y3 = _y + lengthdir_y(_distance, _angle) + lengthdir_y(_distance, _angle + _coneWidth / 2);
// Not convert the coordinates relative to the surface coordinates
x1 -= view_xview[0];
y1 -= view_yview[0];
x2 -= view_xview[0];
y2 -= view_yview[0];
x3 -= view_xview[0];
y3 -= view_yview[0];

// Darken the color based on the given brightness
var r = color_get_red(_color);
var g = color_get_green(_color);
var b = color_get_blue(_color);
r = lerp(0, r, _brightness / 255);
g = lerp(0, g, _brightness / 255);
b = lerp(0, b, _brightness / 255);
var _color = make_color_rgb(r, g, b);

// Draw the light on the light surface
// Since the surface is drawn inverted, we invert this before hand to be brighter when drawn
draw_set_blend_mode(bm_subtract);
surface_set_target(obj_env_light.surface);
draw_set_alpha(_brightness);

draw_triangle_colour(x1, y1, x2, y2, x3, y3, _color, c_black, c_black, false);

draw_set_alpha(1);
surface_reset_target();
draw_set_blend_mode(bm_normal);