///scr_lightFlash(x, y, radius, color);
/* Creates a flash of light
*/

_x = argument0;
_y = argument1;
_radius = argument2;
_color = argument3;

with (instance_create(_x, _y, obj_light)) {
    radius = other._radius;
    color = other._color;
    orgColor = other._color;
    fadeTime = 128;
    orgFadeTime = 128;
}