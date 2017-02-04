///scr_findNearestAvailableCell(id, x, y, cellWidth, cellHeight);
// finds the nearest available / free / unused cell in the pathfinding grid and 
// returns its x and y location

var _id = argument0; // the grid
var _x = argument1; // x pos of original location
var _y = argument2; // y pos of original location
var _cellWidth = argument3; // cell width of the grid
var _cellHeight = argument4; // cell height of the grid

var foundPath = false;
var _searchRange = 2;
var _maxSearchRange = 8;
var _midCellX = _x div _cellWidth; // _fx within the grid (it gets snapped onto the grid)
var _midCellY = _y div _cellHeight; // _fy within the grid (it gets snapped onto the grid)
var _nearestFreeCell;
_nearestFreeCell[0] = noone; // x val
_nearestFreeCell[1] = noone; // y val

// First check if cell at the direct x and y location is available
if (mp_grid_get_cell(_id, _midCellX, _midCellY) == 0) {
    foundPath = true;
    _nearestFreeCellX = _midCellX;
    _nearestFreeCellY = _midCellY;
}

// If haven't found path, search all around the first point, then expanding outward in a square ripple-like search
// until hit the max search range
while (!foundPath && _searchRange <= _maxSearchRange) {
    var halfSearchRange = _searchRange / 2;
    
    for (var i = -halfSearchRange; i <= halfSearchRange; i ++) { // x
        for (var j = -halfSearchRange; j <= halfSearchRange; j ++) { // y
            // If within the outer layer of the search range, don't search
            // as it has already been searched. We use absolute value on i
            // and j as when i is -halfSearchRange or halfSearchRange, (same with j),
            // it is on the outer range, so when can do less checking if we just make
            // it positive no matter what (abs)
            if (abs(i) != halfSearchRange && abs(j) != halfSearchRange) {
                continue;
            }
            //var _posX, _posY;
            // If cell is free, a path is found, set the x and y pos to return
            if (mp_grid_get_cell(_id, _midCellX, _midCellY) != -1) {
                foundPath = true;
                _nearestFreeCell[0] = _midCellX;
                _nearestFreeCell[1] = _midCellY;
                break; // stop search, found a position free
            }
        }
    }
    
    _searchRange += 2; // expand by 2 as we are expanding outwards and the outskirts exist on left and right (and top and bottom)
}

return _nearestFreeCell; // returns array of _nearestFreeCell where [0] is the x value, [1] is the y value