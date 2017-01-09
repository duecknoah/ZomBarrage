///scr_addBackTile(tile num, x, y, xoff, yoff, depth);
/* Adds a mapping background tile for buildings, props, etc.
 * Will automatically get left, top, width, and height based 
 * off the tile number. The tile number is the number of tiles away that tile 
 * is from the start,
 * in PyxelEdit, click view>show tile indices, to show the tile numbers.
 * xoff where 1 makes the final x val be:
     x + indoor_tile_width
 * yoff where 1 makes the final y val be:
     y + indoor_tile_height
 * xoff where 6 makes the final x val be:
    x + (indoor_tile_width * 6)
 */
 
tileNum = argument0;
_x = argument1;
_y = argument2;
xoff = argument3;
yoff = argument4;
_depth = argument5;

_x += indoor_tile_width * xoff;
_y += indoor_tile_height * yoff;

var bg_width = background_get_width(tile_back);
var bg_height = background_get_height(tile_back);
var tiles_per_width = bg_width / indoor_tile_width;
var tiles_per_height = bg_height / indoor_tile_height;
var total_tiles = tiles_per_width * tiles_per_height;
var tl_x = (tileNum mod tiles_per_width)  * indoor_tile_width;
//var tl_y = (tileNum div tiles_per_height) * indoor_tile_height - indoor_tile_height;
var tl_y = floor(tileNum / tiles_per_width) * indoor_tile_height;
//show_message("X: " + string(tl_x) + ", Y: " + string(tl_y) + ", tiles_per_w: " + string(tiles_per_width));
//show_message("tileNum = " + string((tl_y * tiles_per_height) / (indoor_tile_height * tiles_per_height)));

tile_add(tile_indoor, tl_x, tl_y, indoor_tile_width, indoor_tile_height, _x, _y, _depth);