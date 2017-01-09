/// scr_createPointsText(x, y, text, colour);
/* Creates instance obj_pointsText and draws text that moves
 * and fades out in a random direction quickly
*/

var _x = argument0;
var _y = argument1;
var _text = argument2;
var _colour = argument3;

with (instance_create(_x, _y, obj_pointsText)) {
    colour = _colour;
    text = _text;
}