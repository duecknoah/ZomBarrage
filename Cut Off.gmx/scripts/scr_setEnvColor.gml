///scr_setEnvColor(col);
/* Sets the environment color of the map.
*/

tempCol = argument0;

/* Note that we must invert the color as the environment
 * color is using the subtract blend mode to be drawn, so
 * inverting the colors will counter that
*/ 
var r = 255 - color_get_red(tempCol);
var g = 255 - color_get_green(tempCol);
var b = 255 - color_get_blue(tempCol);
var finalCol = make_color_rgb(r, g, b);

obj_env_light.env_color = finalCol;