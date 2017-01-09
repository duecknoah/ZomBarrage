///scr_getDepth(y, depthOffset, isAccurate);
// Returns the depth based on a given y coord
// the lower the y value (higher in game), the higher the depth
// the higher the y value (lower in game), the lower the depth

var _y = argument0;
var _depthOffset = argument1;
// when true, it will not floor result, 
// when false it will. 
// Make true for percise objects (props), make false for big objects (buildings)
var isAccurate = argument2;

if (isAccurate) {
    var d = (-_y / back_tile_height) + _depthOffset
}
else {
    var d = floor(-_y / back_tile_height) + _depthOffset;
}

return d; 