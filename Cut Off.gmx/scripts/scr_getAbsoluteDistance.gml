///scr_getAbsoluteDistance(x1, y1, x2, y2);
// returns the absolute distance between two points

var _x1 = argument0;
var _y1 = argument1;
var _x2 = argument2;
var _y2 = argument3;

return sqrt(sqr(abs(_x2 - _x1)) + sqr(abs(_y2 - _y1)));