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