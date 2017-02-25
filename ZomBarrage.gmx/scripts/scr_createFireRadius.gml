/// scr_createFireRadius(x, y, radius, amount);
/* Creates [amount] fire entities in the 
 * given radius at the given coords.
*/

var _x = argument0;
var _y = argument1;
var _radius = argument2;
var _amount = argument3;

for(var _i = 0; _i < _amount; _i ++) {
    var _moveToX, _moveToY;
    _moveToX = _x + cos(random(pi * 2)) * _radius;
    _moveToY = _y + sin(random(pi * 2)) * _radius;
    
    with (instance_create(_x, _y, obj_fire)) {
        moveToX = _moveToX;
        moveToY = _moveToY;
    }
}
