///scr_addShadowTile(tilenum, x, y, xoff, yoff);
/* Adds a mapping background tile for shadows
 * Will automatically get left, top, width, and height based 
 * off the tile number. The tile number is the number of tiles away that tile 
 * is from the start,
 * in PyxelEdit, click view>show tile indices, to show the tile numbers.
 * xoff where 1 makes the final x val be:
     x + back_tile_width
 * yoff where 1 makes the final y val be:
     y + back_tile_height
 * xoff where 6 makes the final x val be:
    x + (back_tile_width * 6)
 */

tileNum = argument0;
__x = argument1;
__y = argument2;
xoff = argument3;
yoff = argument4;

__x += back_tile_width * xoff;
__y += back_tile_height * yoff;

var __depth = scr_getDepth(__y, 2, false);
var shadowAt = tile_layer_find(__depth, __x, __y);

// If already a tile there already
/*
if (shadowAt != -1) {
    // If is type shadow
    if (tile_get_background(shadowAt) == tile_back_shadows) {
        var shadowAtTileNum = tile_get_left(shadowAt) / back_tile_width;
        
        if (shadowAtTileNum == 2) {
            tileNum = 5;
        }
        else {
            exit;
        }
    }
}
*/

var bg_width = background_get_width(tile_back_shadows);
var tiles_per_width = bg_width / back_tile_width;
var tl_x = tileNum * back_tile_width;
var tl_y = 0;
// show_message("X: " + string(tl_x) + ", Y: " + string(tl_y) + ", tiles_per_w: " + string(tiles_per_width));

// Else if not a shadow tile already there, create one
tile_add(tile_back_shadows, tl_x, tl_y, back_tile_width, back_tile_height, __x, __y, __depth);