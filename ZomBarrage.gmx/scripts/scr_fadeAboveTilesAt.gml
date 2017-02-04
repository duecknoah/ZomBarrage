///scr_fadeAboveTilesAt(x, y, range);
// fades tiles above a position to see whats behind it.
// Range is the distance tiles will fade from the position (relative to back_tile coords)
// ex. if (range == 1) xdist = 64;
// used in player step event

var _x = argument0;
var _y = argument1;
var range = argument2;

var isTileInFront = false;

// First check if there is even a tile_back in front of the player
for(var idepth = scr_getDepth(_y, 0, false); idepth > scr_getDepth(_y, -20, false); idepth --) {
    var tileInFront = tile_layer_find(idepth, _x, _y);
    // If there is a tile in front
    if (tileInFront != -1) {
        // If a background tile (not a shadow for ex.)
        if (tile_get_background(tileInFront) == tile_back) {
            isTileInFront = true;
        }
    }
}

// Make surrounding tiles around that back to normal alpha (else it would stay faded forever)
var xExtension = back_tile_width * 2;
var yExtension = back_tile_height * 2;
for(var iy = _y - (back_tile_height * range) - yExtension; iy <= _y + (back_tile_height * range) + yExtension; iy += back_tile_height) {
    for(var ix = _x - (back_tile_width * range) - xExtension; ix <= _x + (back_tile_width * range) + xExtension; ix += back_tile_width) {
       for(var idepth = scr_getDepth(_y, 0, false); idepth > scr_getDepth(_y, -20, false); idepth --) {
       // Prevent setting the middle ones (where we are fading) to alpha 1
       if (isTileInFront) {
           if (abs(_x - ix) < back_tile_width * range
            || abs(_y - iy) < back_tile_height * range) {
                continue;
           }
       }
       
       var tile = tile_layer_find(idepth, ix, iy);
       
       if (tile != -1) {
           // If an actual background tile (not something like a shadow)
           if (tile_get_background(tile) == tile_back) {
                tile_set_alpha(tile, 1);
           }
       }
       } 
    }
}

// If a tile in front of the coordinates, then fade out tiles
if (isTileInFront) {
    // Fade the tile at
    for(var iy = _y - (back_tile_height * range); iy <= _y + (back_tile_height * range); iy += back_tile_height) {
        for(var ix = _x - (back_tile_width * range); ix <= _x + (back_tile_width * range); ix += back_tile_width) {
           for(var idepth = scr_getDepth(_y, 0, false); idepth > scr_getDepth(_y, -20, false); idepth --) {
           // Prevent setting the middle one (where we are fading) to alpha 1
    
           var tile = tile_layer_find(idepth, ix, iy);
           
           if (tile != -1) {
               // If an actual background tile (not something like a shadow)
               // Then fade into transparency
               if (tile_get_background(tile) == tile_back) {
                    var currentAlpha = tile_get_alpha(tile);
                    var newAlpha = 0;
                    var alphaToFadeTo = 0.25;
                    if (currentAlpha > alphaToFadeTo) {
                        newAlpha = currentAlpha - 0.05;
                    } else {
                        newAlpha = alphaToFadeTo;
                    }
                    tile_set_alpha(tile, newAlpha);
               }
           }
           } 
        }
    }
}