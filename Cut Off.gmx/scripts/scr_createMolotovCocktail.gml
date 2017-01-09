///scr_createMolotovCocktail(x, y, dir, dist);
// Creates a thrown molotov cocktail entity throwing in direction <dir>

var _startX = argument0;
var _startY = argument1;
var _dir = argument2;
var _dist = argument3;

with (instance_create(_startX, _startY, obj_molotovCocktail)) {
    dir = _dir;
    dist = _dist;
    initX = _startX;
    initY = _startY;
}