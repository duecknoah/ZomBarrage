///scr_createThrownGround(x, y, dir, dist, thrower);
// Creates thrown ground entity throwing in direction <dir>

var _startX = argument0;
var _startY = argument1;
var _dir = argument2;
var _dist = argument3;
var _thrower = argument4;

with (instance_create(_startX, _startY, obj_thrownGround)) {
    dir = _dir;
    dist = _dist;
    initX = _startX;
    initY = _startY;
    thrower = _thrower;
}