///scr_createZombieBodyAt(x, y, dir)
// Creates a random dead zombie body at specified coords and direction

var _x = argument0;
var _y = argument1;
var _dir = round((argument2 % 360) / 90); // snap into 4 different directions

var _wTot = background_get_width(tile_zombieDead);
var _hTot = background_get_height(tile_zombieDead);
var _sizeAct = 24;
var _ImgsPerRow = floor(_wTot / _sizeAct);
var _left = floor(random(_ImgsPerRow)) * _sizeAct; // random subimg (left and right)
var _top = _dir * _sizeAct; // top is based on direction (as tiles can't be rotated)

//show_message(string(_left) + " " + string(_top));

// Add the tile
tile_add(tile_zombieDead, 
    _left, _top, _sizeAct, _sizeAct, 
   _x, _y, scr_getDepth(_y, 2, true));