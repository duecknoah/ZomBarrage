///scr_entityMeeting(x, y);
// returns the entity at the specified position, if there is none, it will return noone
var _x = argument0;
var _y = argument1;

var _player = instance_place(_x, _y, obj_player);
if (_player != noone) {
    return _player;
}

var _zombie = instance_place(_x, _y, obj_zombieP);
if (_zombie != noone) {
    return _zombie;
}

return noone; // no collisions detected
