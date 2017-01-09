///scr_isCoordsInMapBounds(x, y);
// Will return true if coordinates specified are within the room
// Will return false if coordinates are out of the room

var _x = argument0;
var _y = argument1;

if (_x < 0 || _x > room_width
  || _y < 0 || _y > room_height) {

    return false;
}

return true;