///scr_addTileCollisionAndShadow(x, y, xoff, yoff, w, h, building_height, isLootAble);
/* Adds the collisions for a tile / building / prop. Then adding
 * shadows based on the dimensions of the collision.
 * width (w) and height (h) are relative to back_tile_width
 * and back_tile_height.
 * ex. if w == 1, then width == w * back_tile_width, so width == 64
 */
 
_x = argument0;
_y = argument1;
xoff = argument2;
yoff = argument3;
w = argument4;
h = argument5;
building_height = argument6;
isLootAble = argument7;

/* Calculate offsets, offsets are relativce to 
 * back_tile_width and back_tile_height
*/
final_x = _x;
final_y = _y;
final_x += xoff * back_tile_width;
final_y += yoff * back_tile_height;

with (instance_create(final_x, final_y, obj_collision)) {
    image_xscale = other.w;
    image_yscale = other.h;
    // Counter-act the image scaling as spr_collision is centered.
    x += (sprite_get_width(spr_collision) / 2) * image_xscale;
    y += (sprite_get_height(spr_collision) / 2) * image_yscale;
}

if (isLootAble) {
    with (instance_create(final_x, final_y, obj_lootArea)) {
    image_xscale = other.w;
    image_yscale = other.h;
    // Counter-act the image scaling as spr_lootArea is centered.
    x += (sprite_get_width(spr_collision) / 2) * image_xscale;
    y += (sprite_get_height(spr_collision) / 2) * image_yscale;
}
}

// Create shadows on shadow_depth (defined in all configurations (macro)

/* We don't use final_x and final_y as those are the ones with specific
 * offsets for the collision box, the shadows are not affected by that
*/
// Top Right
var xx = _x + (w * back_tile_width);
var yy = _y;

for(i = 1; i <= building_height; i ++) {
    scr_addShadowTile(4, xx, yy, 0, 0);
    xx += back_tile_width;
    yy += back_tile_height;
}
// Bottom Left and up one
scr_addShadowTile(0, _x, _y + h * back_tile_height, 0, 0);
// Bottom Left
scr_addShadowTile(1, _x, _y + h * back_tile_height, 0, 1);
// Bottom Left and up one to bottom right and up one, Full shadow boxes
for(i=_x + back_tile_width; i<=_x + (w * back_tile_width); i+=back_tile_width) {
    scr_addShadowTile(2, i, _y + h * back_tile_height, 0, 0);
}
// Top Right down one to Bottom right up one (minus the corner tile, Full shadow boxes
for(i=_y + back_tile_height; i<_y + (h * back_tile_height); i+=back_tile_height) {
    scr_addShadowTile(2, _x + (w * back_tile_width), i, 0, 0);
}
// Bottom Left to bottom right, half shadow boxes
for(i=_x + back_tile_width; i<=_x + (w * back_tile_width); i+=back_tile_width) {
    scr_addShadowTile(3, i, _y + h * back_tile_height, 0, 1);
}